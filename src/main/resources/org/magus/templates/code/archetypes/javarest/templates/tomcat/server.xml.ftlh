<#--To be appended in Tomcat's server.xml file -->
<Context path="/${app.shortName}" 
         docBase="${app.path}/${app.shortName}/WebContent" 
         debug="5" 
         reloadable="true" 
         crossContext="true">
     <!--
	<Resource name="" 
              auth="Container" 
              type="javax.sql.DataSource" 
              maxActive="100" 
              maxIdle="30" 
              maxWait="10000"
              username="" 
              password="" 
              driverClassName=""
              url=""/>
     -->
</Context>
