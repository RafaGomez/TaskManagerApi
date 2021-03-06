Feature: #2 Manage tasks
In order to update my tasks
As an User
I want to manage my tasks


#MODO 2:
Scenario: Add task
	When the user sends a POST request to "/tasks" with the following:
	 """
	 {
	  "Description" : "Buy milk"
	 }
	 """
	Then the response status should be "201"
	And the response body should be a task like:
	    | attribute  | type    | value       |
	    | Description| String  | Buy milk    |
    

Scenario: Remove task
	Given a system with the following tasks
		|id |  Description  	| 
		| 1 | Build an API		| 
		| 2 | Read emails		| 
	When the user sends a DELETE request to "/tasks/2":
	Then the response status should be "204"
	And task 2 should be deleted
    