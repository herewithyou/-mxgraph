<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <c:set var="base" value="${pageContext.request.contextPath}"></c:set>
    <title>editor</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="styles/grapheditor.css">
    <script type="text/javascript">
        var base = '${base}'
    </script>
    <script type="text/javascript">
        // Parses URL parameters. Supported parameters are:
        // - lang=xy: Specifies the language of the user interface.
        // - touch=1: Enables a touch-style user interface.
        // - storage=local: Enables HTML5 local storage.
        // - chrome=0: Chromeless mode.
        var urlParams = (function (url) {
            var result = new Object();
            var idx = url.lastIndexOf('?');

            if (idx > 0) {
                var params = url.substring(idx + 1).split('&');

                for (var i = 0; i < params.length; i++) {
                    idx = params[i].indexOf('=');

                    if (idx > 0) {
                        result[params[i].substring(0, idx)] = params[i].substring(idx + 1);
                    }
                }
            }

            return result;
        })(window.location.href);

        // Default resources are included in grapheditor resources
        mxLoadResources = false;
    </script>
    <script type="text/javascript" src="js/Init.js"></script>
    <script type="text/javascript" src="jscolor/jscolor.js"></script>
    <script type="text/javascript" src="sanitizer/sanitizer.min.js"></script>
    <script type="text/javascript" src="../../../src/js/mxClient.js"></script>
    <script type="text/javascript" src="js/EditorUi.js"></script>
    <script type="text/javascript" src="js/Editor.js"></script>
    <script type="text/javascript" src="js/Sidebar.js"></script>
    <script type="text/javascript" src="js/Graph.js"></script>
    <script type="text/javascript" src="js/Shapes.js"></script>
    <script type="text/javascript" src="js/Actions.js"></script>
    <script type="text/javascript" src="js/Menus.js"></script>
    <script type="text/javascript" src="js/Format.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/Dialogs.js"></script>
    <script type="text/javascript" src="js/jquery-2.1.1.js"></script>
    <link rel="stylesheet" type="text/css" href="src/css/editor.css">
</head>
<body >
    <div id="editor" class="draw" >
        <script type="text/javascript">
            (function () {
                mxResources.loadDefaultBundle = false;
                var bundle = mxResources.getDefaultBundle(RESOURCE_BASE, mxLanguage) ||
                        mxResources.getSpecialBundle(RESOURCE_BASE, mxLanguage);
                // Fixes possible asynchronous requests
                mxUtils.getAll([bundle, STYLE_PATH + '/default.xml'], function (xhr) {
                    // Adds bundle text to resources
                    mxResources.parse(xhr[0].getText());

                    // Configures the default graph theme
                    var themes = new Object();
                    themes[Graph.prototype.defaultThemeName] = xhr[1].getDocumentElement();

                    // Main
                   $.MxEditor= new EditorUi(new Editor(urlParams['chrome'] == '0', themes),document.getElementById("editor"));
                }, function () {
                    document.body.innerHTML = '<center style="margin-top:10%;">Error loading resource files. Please check browser console.</center>';
                });
            })();
        </script>
    </div>
<div >
    <input type="button" id="savexml">
</div>
<script type="text/javascript">
    $("#savexml").click(function(){
        alert(this.editorUi.editor.getGraphXml());
    });
</script>
</body>
</html>