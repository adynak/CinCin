draanks.factory("ListServices", ['$http', '$q', '$rootScope', "Data",
    function($http, $q, $rootScope, Data) {

        var removeItemSql = function(infoList,infoListLabel,position){
            var sql = {};

            sql.action    = 'delete';
            sql.tableName = infoListLabel;
            sql.id        = infoList[position].id;
            sql.name      = infoList[position].name;
            return sql;
        }

        var addItemSql = function(infoList,tableName,newItem){
            var sql = {};

            sql.action    = 'insert';
            sql.tableName = tableName;
            sql.values    = newItem.name;
            return sql;
        }

        var processUpdate = function(infoList, sql, action, newItem,insertPosition){            
            var qObject = $q.defer();
            var params = {
                sql: sql,
                task: action,
                insertAt: insertPosition,
                securityInfo: Data.getSecurityInfo()                
            };

            $http({
                method  : 'POST',
                url     : 'resources/dataServices/listServices.php',
                data    : params,
                headers : {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {

            });
            return qObject.promise;   
        }

        var findIndexInData = function(data, property, value){
            var result = -1;
            var name = value.name
            data.some(function (item, i) {
                if (item[property] >= name) {
                    result = i;
                    return true;
                }
            });
            return result;
        }

        var insertNewItem = function(newItem,infoList,tableName){
            var sql = {}, results = {};
            var insertPosition;
            var action = 'addItem';

            insertPosition = findIndexInData(infoList, 'name', newItem);
            if (insertPosition < 0){
                infoList.push(newItem);
            } else {
                infoList.splice(insertPosition, 0, newItem);
            }
           
            sql = addItemSql(infoList,tableName,newItem);

            var ajaxResults = processUpdate(infoList,sql,action,newItem,insertPosition);
            return ajaxResults ;
        }        
        
        var getGridHeight = function(gridOptions,gridApi) {
            var cocktails = gridOptions.data.length;
            var categories = [];
            var categoryCount = 0;
            var gridHeight,moveUp;
            for (x = 0; x < cocktails ; x ++){
                category = gridOptions.data[x].category;
                if ($.inArray(category, categories) == -1) {
                    categories.push(category);
                    categoryCount++;
                }
            }

            var rowHeight = 30; // your row height
            var headerHeight = 40; // your header height
            var filterHeight = 0; // your filter height
            var height = (cocktails + categoryCount) * rowHeight + headerHeight + filterHeight;
            if (height > 360){
                gridDimensions = {'gridHeight':'360px','moveUp':'0px'};
            } else {
                gridHeight = height + "px";
                moveUp = -10 + "px"
                gridDimensions = {'gridHeight':gridHeight,'moveUp':moveUp};
            }
            return gridDimensions;

        }

        return {
            removeItemSql:      removeItemSql,
            processUpdate:      processUpdate,
            insertNewItem:      insertNewItem,
            getGridHeight:      getGridHeight
        };
    }
]);