<?php
// $fp = fopen('/Library/PostgreSQL/EnterpriseDB-ApachePhp/apache/www/CinCin/test.txt','a+');
$fp = fopen('/Library/WebServer/Documents/angular/git/CinCin/test.txt','a+');

$debug = true ;

session_start();
$data = json_decode(file_get_contents("php://input"));

$dbSchema = $data->securityInfo->schema;
$dbPass   = $data->securityInfo->dbPass;
$pgPort   = $data->securityInfo->pgPort;

class tracker {
  public $IP;
  public $timeStamp;
  public $cocktail;

  function __construct($cocktail)  
    { 
        $this->IP = getRealIpAddr(); 
        $this->timeStamp = time(); 
        $this->cocktail = $cocktail;
    } 
}

function getRealIpAddr()
{
  $ip = "unknown";

  if (!empty($_SERVER['HTTP_CLIENT_IP']))   //check ip from share internet
  {
    $ip=$_SERVER['HTTP_CLIENT_IP'];
  }
  elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //to check ip is pass from proxy
  {
    $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
  }
  else
  {
    $ip=$_SERVER['REMOTE_ADDR'];
  }
  return $ip;
}

$dbSchema = "draanks";
$dbPass   = "Ad17934!";
$pgPort   = 5432;


$conn_string = "host=127.0.0.1 port=$pgPort dbname=postgres user=postgres password=$dbPass";
$conn = pg_connect($conn_string);

if ($data->task == 'validate') {
  $debug = false;
  $myArray    = array();

  $sql  = "select row_to_json(t) ";
  $sql .= "from (";
  $sql .= "select * from $dbSchema.members where ";
  $sql .= "email='"      . $data->email    . "' and ";
  $sql .= "password = '" . $data->password . "'";
  $sql .= ") t";

  $result = pg_query($conn, $sql);
  $row_cnt = pg_num_rows($result);
  if ($row_cnt == 1) {
    $row = pg_fetch_row($result);
    $member = json_decode($row[0]);
    $myArray['validated'] = 'success';
    $myArray['member'] = $member;
    echo json_encode($myArray);
    $_SESSION["currentuser"] = $member->onlineid;
  } else {
    echo 'The email or password you have entered is invalid.';
  }
}

else if ($data->task == 'getsessiondata') {
  $debug = false ;
    $myArray = array();
    if(isset($_SESSION["currentuser"]))
    {
      $sql = "SELECT * FROM $dbSchema.members where onlineID='" . $_SESSION["currentuser"] . "'";
      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {
          $myArray[] = $row;
        }
        if (sizeof($myArray) > 0) {
          $myArray['id'] = 'new';
        }
        echo json_encode($myArray);
      }
    } else {
      echo 'nosession';
    }    
}

else if ($data->task == 'getMemberInfo') {
    $myArray = array();
    if(isset($_SESSION["currentuser"]))
    {
      $sql = "SELECT * FROM $dbSchema.members where onlineID != '" . $_SESSION["currentuser"] . "'";
      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {
          $myArray[] = $row;
        }
        echo json_encode($myArray);
      }
    } else {
      echo 'nosession';
    }    
}

else if ($data->task == 'getIngredients') {
  $debug = false;
    $myArray = array();
    if(isset($_SESSION["currentuser"]))
    {
      $sql = "SELECT * FROM $dbSchema.ingredient order by name";
      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {
          $myArray[] = $row;
        }
        echo json_encode($myArray);
      }
    } else {
      echo 'nosession';
    }    
}

else if ($data->task == 'getCocktails') {
  $debug = true;
    $myArray = array();
    if(isset($_SESSION["currentuser"]))
    {

      $sql  = "SELECT  ";
      $sql .= "  $dbSchema.recipe.name as cocktail, ";
      $sql .= "  $dbSchema.category.name as category, ";
      $sql .= "  $dbSchema.textcat_all($dbSchema.recipe.portions || ', ') as portions, ";
      $sql .= "  $dbSchema.textcat_all($dbSchema.recipeingredient.quantity || ', ') as quantity,   ";
      $sql .= "  $dbSchema.textcat_all($dbSchema.measure.name || ', ') as measure, ";
      $sql .= "  $dbSchema.textcat_all($dbSchema.ingredient.name || ', ') as ingredient, ";
      $sql .= "  $dbSchema.textcat_all($dbSchema.recipeingredient.garnish || ', ') as garnish, ";
      $sql .= "  $dbSchema.textcat_all($dbSchema.recipeingredient.mixorder || ', ') as mixorder  ";

      $sql .= "FROM  ";
      $sql .= "  $dbSchema.recipeingredient, ";
      $sql .= "  $dbSchema.measure, ";
      $sql .= "  $dbSchema.ingredient, ";
      $sql .= "  $dbSchema.recipe, ";
      $sql .= "  $dbSchema.category ";
      $sql .= "where ";
      $sql .= "  $dbSchema.recipeingredient.measureid=$dbSchema.measure.id and ";
      $sql .= "  $dbSchema.ingredient.id=$dbSchema.recipeingredient.ingredientid and ";
      $sql .= "  $dbSchema.recipeingredient.recipeid=$dbSchema.recipe.id and ";
      $sql .= "  $dbSchema.recipe.categoryid=$dbSchema.category.id ";
      $sql .= "GROUP BY  ";
      $sql .= "  $dbSchema.category.name, ";
      $sql .= "  $dbSchema.recipe.name ";
      $sql .= "order by ";
      $sql .= "  $dbSchema.category.name, ";
      $sql .= "  $dbSchema.recipe.name ";

      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {

          $garnishItems = array();
          $quantity   = explode(', ',$row['quantity']);
          $measure    = explode(', ',$row['measure']);
          $ingredient = explode(', ',$row['ingredient']);
          $mixorder   = explode(', ',$row['mixorder']);
          $portions   = explode(', ',$row['portions']);
          $garnish    = explode(', ',$row['garnish']);
          $max = count($mixorder);
          unset($mixorder[$max-1]);
          unset($garnish[$max-1]);
          $recipe      = array();
          $ingredients = array();          
          $max = count($mixorder);

          for ($x = 0 ; $x < $max ; $x++){
            $step = $quantity[$x] . ' ' . $measure[$x] . ' ' . $ingredient[$x];
            if ($garnish[$x] == 0) {
              $recipe[$mixorder[$x]] = $step;
              $ingredients[$mixorder[$x]] = $ingredient[$x];
            } else {
              $garnishItems[] = $step;
            }
          }

          $row['portions'] = $portions[0];
          $row['ingredients'] = $ingredients;

          $row['garnish'] = $garnishItems;
          $row['recipe'] = $recipe;
          $myArray[] = $row;
        }
        echo json_encode($myArray);
      }
    } else {
      echo 'nosession';
    }    
}

else if ($data->task == 'getCategories') {
  $debug = false;
    $myArray = array();
    if(isset($_SESSION["currentuser"]))
    {
      $sql = "SELECT * FROM $dbSchema.category order by name";
      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {
          $myArray[] = $row;
        }
        echo json_encode($myArray);
      }
    } else {
      echo 'nosession';
    }    
}

else if ($data->task == 'getMeasures') {
  $debug = false;
    $myArray = array();
    if(isset($_SESSION["currentuser"]))
    {
      $sql = "SELECT * FROM $dbSchema.measure order by upper(left(name, 1))";
      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {
          $myArray[] = $row;
        }
        echo json_encode($myArray);
      }
    } else {
      echo 'nosession';
    }    
}

else if ($data->task == 'register') {
    $debug = false;
    $pword_type = 0 ;
    $member_type = 0 ;
    $sql = "select count(*) from $dbSchema.members where email='" . $data->userInfo->email . "' or onlineid = '" . $data->userInfo->onlineid . "'";
    $result = pg_query($conn, $sql);
    $row_cnt = pg_fetch_row($result);

    if ($row_cnt[0] >= 1) {
        echo 'onlineID or email already exists';
    } else {
        $sql  = "insert into $dbSchema.members (";
        $sql .= "onlineid, ";
        $sql .= "name_first, ";
        $sql .= "name_last, ";
        if (!is_null($data->userInfo->name_business)){
          $sql .= "name_business, ";
        }
        if (!is_null($data->userInfo->occupation)){
          $sql .= "occupation, ";
        }
        $sql .= "email, ";
        $sql .= "phone_main, ";
        if (!is_null($data->userInfo->phone_secondary)){
          $sql .= "phone_secondary, ";
        }
        if (!is_null($data->userInfo->comments)){
          $sql .= "comments, ";
        }
        $sql .= "password,";
        $sql .= "pword_type,";
        $sql .= "member_type) values ('";

        $sql .= $data->userInfo->onlineid          . "', '";
        $sql .= $data->userInfo->name_first        . "', '";        
        $sql .= $data->userInfo->name_last         . "', '";
        if (!is_null($data->userInfo->name_business)){        
          $sql .= $data->userInfo->name_business     . "', '";
        }
        if (!is_null($data->userInfo->occupation)){
          $sql .= $data->userInfo->occupation      . "', '";
        }
        $sql .= $data->userInfo->email             . "', '";
        $sql .= $data->userInfo->phone_main        . "', '";
        if (!is_null($data->userInfo->phone_secondary)){
          $sql .= $data->userInfo->phone_secondary . "', '";
        }
        if (!is_null($data->userInfo->comments)){
          $sql .= $data->userInfo->comments        . "', '";
        }
        $sql .= $data->userInfo->password          . "', '";
        $sql .= $pword_type                        . "', '";
        $sql .= $member_type                       . "'); ";

        // $result = pg_query($conn, $sql);
        if (1) {
          echo "Error: " . $sql . "<br>" ;
        } else {
          echo 'success';
        }            
    }
}

else if ($data->task == 'logout') {    
    unset($_SESSION['currentuser']);
    if(!isset($_SESSION['currentuser'])){
        echo 'success';
    } else {
        echo 'failed to destroy session';
    }
}

else if ($data->task == 'addToLibrary') {
  $debug = false ;
// create a recipe entry
  $sql  = "insert into $dbSchema.recipe (";
  $sql .= "name, "  ;
  $sql .= "portions, "  ;  
  $sql .= "categoryid, "  ;
  $sql .= "bittersid) "  ;
  $sql .= "values ('"  ;
  $sql .= $data->cocktail->name                . "', '"; 
  $sql .= $data->cocktail->serves->name        . "', '"; 
  $sql .= $data->cocktail->category->id        . "', '"; 
  $sql .= $data->cocktail->tasteProfile->id    . "')  ";   

  $result = pg_query($conn, $sql);
  if (!$result) {
    $addMsg = "Error: " . $sql . "<br>" ;
  } else {
    $addMsg = 'success';
    $sql = "SELECT max(id) FROM $dbSchema.recipe";
      $result = pg_query($conn, $sql);
      if (!$result) {
        echo "Error: " . $sql . '<br>' ;
      } else {
        while ($row = pg_fetch_assoc($result)) {
          $myArray[] = $row;
        }
        $recipeID = $myArray[0][max];
        $ingredientCount = count($data->cocktail->ingredients);
        for ($x = 0 ; $x < $ingredientCount ; $x ++)
        {
          $sql  = "insert into $dbSchema.recipeingredient (";
          $sql .= "recipeid, ";
          $sql .= "ingredientid, ";
          $sql .= "quantity, ";          
          $sql .= "measureid, ";
          $sql .= "garnish, ";          
          $sql .= "mixorder) ";
          $sql .= "values ('"  ;
          $sql .= $recipeID                                       . "', '"; 
          $sql .= $data->cocktail->ingredients[$x]->ingredientID  . "', '"; 
          $sql .= $data->cocktail->ingredients[$x]->amount        . "', '"; 
          $sql .= $data->cocktail->ingredients[$x]->measureID     . "', '"; 
          $sql .= $data->cocktail->ingredients[$x]->garnishFlag   . "', '"; 
          $sql .= $x                                              . "') ;"; 
          $result = pg_query($conn, $sql);
          if (!$result) {
            echo "Error: " . $sql . "<br>" ;
          } else {
            echo 'success';
          }      

        }
      }


  }

}

else if ($data->task == 'updateuser') {
// use !is_null() to avoid inserting null strings into $dbSchema.members for non-required fields
  $debug = false;
    if(isset($_SESSION["currentuser"]))
    {
        $sql = "select count(*) from $dbSchema.members where email !='" . $data->email . "' and onlineid = '" . $data->username . "'";

        $result = pg_query($conn, $sql);
        $row_cnt = pg_fetch_row($result);

        if ($row_cnt[0] == 1) { 
          echo ('usernameexists');
        } else {
          $sql  = "update $dbSchema.members set ";
          $sql .= "name_first = '"      . $data->userInfo->name_first      . "', ";
          $sql .= "name_last = '"       . $data->userInfo->name_last       . "', ";
          $sql .= "name_business = '"   . $data->userInfo->name_business   . "', ";
          if (!is_null($data->userInfo->occupation)){
            $sql .= "occupation = '"      . $data->userInfo->occupation      . "', ";
          }
          $sql .= "email = '"           . $data->userInfo->email           . "', ";
          $sql .= "phone_main = '"      . $data->userInfo->phone_main      . "', ";
          if (!is_null($data->userInfo->phone_secondary)){
            $sql .= "phone_secondary = '" . $data->userInfo->phone_secondary . "', ";
          }
          if (!is_null($data->userInfo->comments)){
            $sql .= "comments = '"        . $data->userInfo->comments        . "', ";
          }
          $sql .= "password = '"        . $data->userInfo->password        . "'  ";
          $sql .= "where id ='"         . $data->userInfo->id              . "'; ";
          $result = pg_query($conn, $sql);
          if (!$result) {
            echo "Error: " . $sql . "<br>" ;
          } else {
            echo 'success';
          }            
        }
    } else {
        echo 'nosession';
    }
}

else if ($data->task == 'trackDraanks') {

  $tracker = new tracker($data->cocktail); 
  
  $logFile = fopen('/Library/WebServer/Documents/CinCin/usageTracking/draanks.csv','a+');
  fwrite($logFile , "\n");  
  fwrite($logFile , $tracker->IP . ",");
  fwrite($logFile , $tracker->timeStamp . ",");
  fwrite($logFile , $tracker->cocktail);
  fclose($logFile);


}

if ($debug) {
  fwrite($fp , 'task = ' . print_r($data->userInfo,1));
  fwrite($fp , "\n");
  fwrite($fp , print_r($member,1));
  fwrite($fp , "\n");
  fwrite($fp , 'sql = ' . $sql);
  fwrite($fp , "\n");
  fwrite($fp, "row = " . print_r($row,1));
  fwrite($fp , "\n");
  //   fwrite($fp , 'mixorder = ' . print_r($mixorder,1));
  // fwrite($fp , "\n");

  fwrite($fp , 'session = ' . $_SESSION["currentuser"]);
  fwrite($fp , "\n");
  // if (sizeof($myArray) > 0) {
  //   fwrite($fp , json_encode($myArray));
  //   fwrite($fp , "\n");
    fwrite($fp , print_r($myArray,1));
    fwrite($fp , "\n");
  //   fwrite($fp , $myArray[0][max]);
  //   fwrite($fp , "\n");
  // }
  fwrite($fp , "\n");
  // fwrite($fp , print_r($addMsg,1));

  $debug = false ;
}

?>