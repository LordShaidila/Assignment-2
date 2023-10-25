import ballerina/graphql;



public client class Client {
   final graphql:Client Client;
  // This is a class to be called by the main method to perform the operations and then the server does the heavy lifting
//   This class defines the graphql mutations
    
       public isolated function init(string url, graphql:ClientConfiguration Config = {}) returns error? {
       
        graphql:Client Client1 = check new (url, Config);
        self.Client = Client1;

        return null;
    }

   

    remote function EmployeeCreateKPI(string EID, string DESC, float Score) returns json|error {
        string filter = "mutation EmployeeCreateKPI($EID: String!, $DESC: String!, $Score: Float!) { employeeCreateKPI(EID: $EID, DESC: $DESC, Score: $Score) }";
        map<json> details = { "EID": EID, "DESC": DESC, "Score": Score };
        json createdKPI = check self.Client->execute(filter, details);
        return createdKPI;
    }

    remote function AssignEmployeeToSupervisor(string staffID, string SID) returns json|error {
        string filter = "mutation AssignEmployeeToSupervisor($staffID: String!, $SID: String!) { AssignEmployeeToSupervisor(staffID: $staffID, SID: $SID) }";
        map<json> deets = { "staffID": staffID, "supervisorId": SID };
        json assignResponse = check self.Client->execute(filter, deets);
        return assignResponse;
    }

    remote function gradeEmployeeKPI(string SID, string EID, string kpiId, float grade) returns json|error {
        string filter = "mutation GradeEmployeeKPI($SID: String!, $EID: String!, $kpiId: String!, $grade: Float!) { gradeEmployeeKPI(supervisorId: $supervisorId, employeeId: $employeeId, kpiId: $kpiId, score: $score) }";
        map<json> deets = { "SID": SID, "EID": EID, "kpiId": kpiId, "grade": grade };
        json grades = check self.Client->execute(filter, deets);
        return grades;
    }

    remote function updateKPI(string SID, string EID, string kpiId, float newgrade) returns json|error {
        string filter = "mutation updateKPI($SID: String!, $EID: String!, $kpiId: String!, $newgrade: Float!) { updateKPI(SID: $SID, EID: $EID, kpiId: $kpiId, newgrade: $newgrade) }";
        map<json> deets = { "SID": SID, "EID": EID, "kpiId": kpiId, "newgrade": newgrade };
        json response = check self.Client->execute(filter, deets);
        return response;
    }

    remote function deleteKPI(string SID, string EID, string kpiId) returns json|error {
        // Here we are creating a filter/query which basically just defines the mutation that can be called by the main function
        string filter = "mutation DeleteKPI($SID: String!, $EID: String!, $kpiId: String!) { DeleteKPI(SID: $SID, EID: $EID, kpiId: $kpiId) }";
        map<json> deets = { "SID": SID, "EID": EID, "kpiId": kpiId };
        json deleted = check self.Client->execute(filter, deets);
        return deleted;
    }

    remote function ApproveEmployeeKPI(string SID, string EID, string kpiId) returns json|error {
        string filter = "mutation ApproveEmployeeKPI($SID: String!, $EID: String!, $kpiId: String!) { ApproveEmployeeKPI(SID: $SID, EID: $EID, kpiId: $kpiId) }";
        map<json> deets = { "SID": SID, "EID": EID, "kpiId": kpiId };
        json approved = check self.Client->execute(filter, deets);
        return approved;
    }

    remote function deleteDepartmentObjectives(string DID) returns json|error {
        string filter = "mutation DeleteObjectives($DID: String!) { deleteObjectives(DID: $DID) }";
        map<json> deets = { "departmentId": DID };
        json deleted = check self.Client->execute(filter, deets);
        return deleted;
    }

     remote function HODCreateDepartment(string DID, string DNAME) returns json|error {
        string filter = "mutation HODCreateDepartment($DID: String!, $DNAME: String! ) { hODCreateDepartment(departmentID: $id, departmentName: $departmentName) }";
        map<json> deets = { "DID": DID, "DNAME": DNAME };
        json response = check self.Client->execute(filter, deets);
        return response;
    }
}
