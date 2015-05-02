Feature: Watch my pending tasks
In order to be more productive
As an User
I want to watch my pending tasks


#MODO 1: Más legible para personal no técnico
Scenario: List task
 Given a system with the following tasks
	|id |  Description  	| 
	| 1 | Build an API		| 
	| 2 | Read emails		| 
 When the user request a list of task
 Then the response is a list with 2 tasks
 And one task has the following attributes:
    | attribute  | type    | value        |
    | Description| String  | Build an API |
    | id         | int     | 1            |
 And one task has the following attributes:
    | attribute  | type    | value       |
    | Description| String  | Read emails |
    | id         | int     | 2		     |