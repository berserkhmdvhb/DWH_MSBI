---
// TODO: Add your code here
var startRow = ((Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) - 1) * 10) + 1;
var endRow = Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) * 10;

string sqlQuery = $@"SELECT * FROM CustomerDWH.dbo.tblCustomerTemp WHERE RowNumber BETWEEN {startRow} AND {endRow}";

Dts.Variables["User::DynamicSQLQuery"].Value = sqlQuery;
Dts.TaskResult = (int)ScriptResults.Success;
---
// TODO: Add your code here
var startRow = ((Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) - 1) * 10) + 1;
var endRow = Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) * 10;

string sqlQuery = $@"SELECT * FROM CustomerDWH.dbo.tblCustomerTemp WHERE RowNumber BETWEEN {startRow} AND {endRow}";

Dts.Variables["User::DynamicSQLQuery"].Value = sqlQuery;
Dts.TaskResult = (int)ScriptResults.Success;
---
// TODO: Add your code here
var startRow = ((Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) - 1) * 10) + 1;
var endRow = Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) * 10;

string sqlQuery = $@"SELECT * FROM CustomerDWH.dbo.tblCustomerTemp WHERE RowNumber BETWEEN {startRow} AND {endRow}";

Dts.Variables["User::DynamicSQLQuery"].Value = sqlQuery;
Dts.TaskResult = (int)ScriptResults.Success;
---
    // TODO: Add your code here
    int numberOfFiles = Convert.ToInt32(Dts.Variables["User::NoFiles"].Value);
    Object[] filesToCreate = new Object[numberOfFiles];

    for (int i = 0; i < numberOfFiles; i++)
    {
        filesToCreate[i] = i + 1; // Arrays are zero-based, file numbers start from 1
    }

    Dts.Variables["User::FilesToCreate"].Value = filesToCreate;

    Dts.TaskResult = (int)ScriptResults.Success;
}
---
    // TODO: Add your code here
    int numberOfFiles = Convert.ToInt32(Dts.Variables["User::NoFiles"].Value);
    Object[] filesToCreate = new Object[numberOfFiles];

    for (int i = 0; i < numberOfFiles; i++)
    {
        filesToCreate[i] = i + 1; // Arrays are zero-based, file numbers start from 1
    }

    Dts.Variables["User::FilesToCreate"].Value = filesToCreate;

    Dts.TaskResult = (int)ScriptResults.Success;
}
---
    // TODO: Add your code here
    int numberOfFiles = Convert.ToInt32(Dts.Variables["User::NoFiles"].Value);
    Object[] filesToCreate = new Object[numberOfFiles];

    for (int i = 0; i < numberOfFiles; i++)
    {
        filesToCreate[i] = i + 1; // Arrays are zero-based, file numbers start from 1
    }

    Dts.Variables["User::FilesToCreate"].Value = filesToCreate;

    Dts.TaskResult = (int)ScriptResults.Success;
}
---
  // TODO: Add your code here
  var startRow = ((Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) - 1) * 10) + 1;
  var endRow = Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) * 10;

  string sqlQuery = $@"SELECT * FROM CustomerDWH.dbo.tblCustomerTemp WHERE RowNumber BETWEEN {startRow} AND {endRow}";

  Dts.Variables["User::DynamicSQLQuery"].Value = sqlQuery;
  Dts.TaskResult = (int)ScriptResults.Success;
---
  // TODO: Add your code here
  var startRow = ((Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) - 1) * 10) + 1;
  var endRow = Convert.ToInt32(Dts.Variables["User::CurrentFileNumber"].Value) * 10;

  string sqlQuery = $@"SELECT * FROM CustomerDWH.dbo.tblCustomerTemp WHERE RowNumber BETWEEN {startRow} AND {endRow}";

  Dts.Variables["User::DynamicSQLQuery"].Value = sqlQuery;
  Dts.TaskResult = (int)ScriptResults.Success;
