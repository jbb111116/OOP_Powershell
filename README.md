# OOP_Powershell
Repo to begin testing OOP principles for App Support applications

What I need currently:
Need DTO layer, where it transfers the information internally
Need Service layer, where it applies the logic to different objects
Need Model layer, to have models that we can use for uniformity within all layers
Need Repo/DAO layer, to retrieve information from external sources
Need controller layer, delegates the request/command from the UI/terminal layer, could be renamed to module layer

Service layer - could be split into different service folders - MonitoringServices and AutomatedResponseServices. MonitoringServices hold monitors for the 4 golden signals - latency, saturation, errors and traffic. Saturation and errors are the most straightforward to implement. Traffic and latency will be a bit more difficult to monitor. AutomatedResponseServices will hold the services executing the logic to restart services/servers, bring servers in/out of load, failed deployments rollbacks, sending out notifications, etc.

Model layer - will hold the classes that will be used to run the service layer logic on.

DTO layer - will be used to move the data received/input within the module to set the values of the objects

Repo/DAO layer