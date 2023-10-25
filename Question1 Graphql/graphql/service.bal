import ballerina/graphql;
import ballerinax/mongodb;

mongodb:ConnectionConfig mongoConfig = {
    connection: {
        url: "mongodb+srv://Shaidila:Shaidila@cluster0.q8clcgj.mongodb.net/Graphql"
    },
    databaseName: "Graphql"
};
mongodb:Client mongoClient = check new (mongoConfig);

 service graphql:Service /performanceapi on new graphql:Listener(9090) {
     remote function HODCreateDepartment(string DID, string DNAME) returns string | error {
    string DBcollection = "Departments";
    
    map<json> departmentDeets = {DID: DID, DNAME: DNAME};
    
    var _ = check mongoClient->insert(departmentDeets, DBcollection);
    return "Created Department";
}

 remote function createKPI(string EID, string DESC, float Score) returns string | error {
    string DBcollection = "KPIs";
    map<json> KPIDEETS = {
        "EID": EID,
        "DESC": DESC,
        "Score": Score
    };

    check mongoClient->insert(KPIDEETS, DBcollection);
    return "KPI Created Successfully";
}


remote function assignEmployeeToSupervisor(string EID, string SID) returns int|error {
    string collection = "Employees";

    map<json> ST = { "$set": { "SID": SID } };
    map<json> filter = { "EID": EID };
  
     int res = checkpanic mongoClient->update(ST, collection, (), filter, false, true);
      
     return res;
    }

remote function gradeSupervisor(string EID, string SID, float Score) returns string | error {
    string collection = "Supervisor";
    map<json> update = { "$set": { "Score": Score } };
    map<json> filter = { "SID": SID };
    int _ = checkpanic mongoClient->update(update, collection, (), filter, false, true);
    return "Supervisor was graded successfully";
    
}




remote function gradeKPI(string SID, string EID, string kpiId, float Score) returns string | error {
    string collection = "KPIs";
    map<json> update = { "$set": { "Score": Score } };
    map<json> filter = { "kpiId": kpiId, "EID": EID, "SID": SID };
    int _ = checkpanic mongoClient->update(update, collection, (), filter, false, true);
    
     return "The Employee's KPIs were successfully graded";
    
}

remote function updateKPI(string SID, string EID, string kpiId, float newgrade) returns string | error {
    string collection= "KPIs";
    map<json> filter = { "kpiId": kpiId, "EID": EID, "SID": SID };
    map<json> update = { "$set": { "score": newgrade } };
    int _ = checkpanic mongoClient->update(update, collection, (), filter, false, true);
    return "Employee's KPIs were updated";
  
}


remote function deleteKPI(string SID, string EID, string kpiId) returns string | error {
    string collection = "KPIs";
    map<json> filter = { "kpiId": kpiId, "EID": EID, "SID": SID };
    int _ = check mongoClient->delete(collection, (), filter, true);

    return "Deleted KPI";
    
}


remote function deleteObjectives(string DID) returns string | error {
    string collection = "Departments";
    map<json> filter = { "DID": DID };
    int _ = check mongoClient->delete(collection,(), filter, true);
    return "Deleted Department Objective";
}

remote function approveEmployeeKPI(string SID, string EID, string kpiId) returns string | error {
    string collection = "Approved";
    map<json> filter = { "kpiId": kpiId, "EID": EID, "SID": SID };
    map<json> update = { "$set": { "approved": true } };
    int _ = checkpanic mongoClient->update(update, collection, (), filter, false, true);

    return "KPI Approved";
   
}
 resource function get getEmployees() returns string {
        return "Employees.";
    }







}






