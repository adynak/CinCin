<?php

	$fp = fopen('/Library/WebServer/Documents/angular/git/CinCin/test.txt','a+');

	$results = array(); 
	$newID   = '';

	$debug = false ;

	function sQuote($str){
		return "'$str'";
	}

	session_start();
	$data = json_decode(file_get_contents("php://input"));
	$dbSchema = $data->securityInfo->schema;
	$dbPass   = $data->securityInfo->dbPass;
	$pgPort   = $data->securityInfo->pgPort;
	$pgPort   = 5432;

	$conn_string = "host=127.0.0.1 port=$pgPort dbname=postgres user=postgres password=$dbPass";
	$conn = pg_connect($conn_string);

	if ($data->task == 'removeItem') {
		$debug = false;

		$sql  = $data->sql->action . ' ' ;
		$sql .= 'from ' . $dbSchema .  '.' . $data->sql->tableName . ' ';
		$sql .= 'where id = ' . $data->sql->id ;

		$resource = pg_query($conn, $sql);
		$result = pg_affected_rows($resource);

        if (!resource || !$result) {
			$results['success'] = false;
			$results['newID']   = $newID;
        } else {
			$results['success'] = true;
			$results['newID']   = $newID;
        }           
	} 
	
	else if ($data->task == 'addItem') {
		$debug = false;

		$sql  = 'insert into ';
		$sql .= $dbSchema . '.' . $data->sql->tableName . ' (name)';
		$sql .= ' values (';
		$sql .= sQuote($data->sql->values);
		$sql .= ');';

		$resource = pg_query($conn, $sql);
		$result = pg_affected_rows($resource);

		if (!resource || !$result) {
			$results['success'] = false;
			$results['newID']   = $newID;
        } else {
			$results['success'] = true;

			$sql  = 'select id ';
			$sql .= 'from ' . $dbSchema . '.' . $data->sql->tableName . ' ';
			$sql .= 'where name = ' . sQuote($data->sql->values);

			$result = pg_query($conn, $sql);
			$row    = pg_fetch_assoc($result);
			$newID  = $row['id'];

			$results['newID']    = $newID;
			$results['insertAt'] = $data->insertAt;
        }           

	}

	echo json_encode($results);

	if ($debug) {
	  fwrite($fp , 'task = ' . print_r($data->task,1));
	  fwrite($fp , "\n");
	  fwrite($fp , print_r($data,1));
	  fwrite($fp , "\n");
	  fwrite($fp , 'sql = ' . $sql);
	  fwrite($fp , "\n");

	  fwrite($fp , 'results = ' . $results);
	  fwrite($fp , "\n");
	  fwrite($fp , 'mixorder = ' . print_r($mixorder,1));
	  fwrite($fp , "\n");

	  fwrite($fp , 'session = ' . $_SESSION["currentuser"]);
	  fwrite($fp , "\n");
	  if (sizeof($myArray) > 0) {
	    fwrite($fp , json_encode($myArray));
	    fwrite($fp , "\n");
	    fwrite($fp , print_r($myArray,1));
	    fwrite($fp , "\n");
	    fwrite($fp , $myArray[0][max]);
	    fwrite($fp , "\n");
	  }
	  fwrite($fp , "\n");
	  // fwrite($fp , print_r($results,1));

	  $debug = false ;
	}


?>