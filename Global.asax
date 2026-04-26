<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.Web.UI" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
          // Code that runs on application startup
        ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
        {
            Path = "~/Scripts/jquery-3.7.1.min.js",
            DebugPath = "~/Scripts/jquery-3.7.1.js",
            CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.1.min.js",
            CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.1.js"
        });
    }

    void Application_End(object sender, EventArgs e)
    {
  //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
         // Code that runs when an unhandled error occurs

    }

</script>

