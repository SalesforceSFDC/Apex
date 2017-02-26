/**

	Notes:
		- API endpoint accepts JSON similar to:
			{
				"id": "ch_abcdefghijklmnopqrstuvwx",
				"amount": 9900,
				"description": "vukdukic@gmail.com",
				"source": {
					"id": "card_123456789123456789123456",
					"brand": "Visa",
					"exp_month": 11,
					"exp_year": 2021,
					"last4": "2222",
					"name": "vukdukic@gmail.com"
				},
				"status": "succeeded",
				"type": "charge.succeeded"
			}
		- queries for the Contact with the email address provided in the description key/value pair from the JSON request
		- creates a Task
		- returns JSON similar to:
			{
				"status": "success",
				"contactid": "0033000000YVLQWAA5",
				"taskid": "00T3000000rEvJtEAK",
				"message": ""
			}
**/
	
//@RestResource annotation exposes the class as a REST resource
@RestResource(urlMapping='/demo/createTask/*') //endpoint definition > {Salesforce Base URL}/services/apexrest/demo/createTask/
global class createTask {
	
	//primary logic for the class
	@HttpPost //HttpPost annotation exposes the method as a REST resource and called when an HTTP POST request is sent
	global static responseWrapper taskCreationLogic() {
		
		RestRequest req = RestContext.request; //the RestRequest for the Apex REST method
		responseWrapper responseJSON = new responseWrapper(); //responseWrapper object for API response
		
		String typeOfCard = ''; //placeholder for the type of card string
		String last4OfCard = ''; //placeholder for the last four digits of the card
		String emailAddress = ''; //placeholder for an email address
		Map<String, Object> body = new Map<String, Object>(); //placeholder for the JSON Body of the request
		Map<String, Object> src = new Map<String, Object>(); //placeholder for the source object from the JSON request
		
		String jsonBody = req.requestBody.toString(); //the body of the request
		
		if (!String.isBlank(jsonBody)) { //if the request body is NOT white space, empty ('') or null
			body = (Map<String, Object>)JSON.deserializeUntyped(jsonBody); //deserializes the JSON string into collections of primitive data types
			if (body.containsKey('description')) { //if there is a key of description in our body map
				emailAddress = (String)body.get('description'); //grab the value for the description key from the body map and cast it to a string
				List<Contact> queriedContacts = [SELECT Id FROM Contact WHERE Email = :emailAddress ORDER BY CreatedDate DESC LIMIT 1]; //query for a Contact that has the email address
				if (!queriedContacts.isEmpty()) { //if the list is not empty
					if (body.containsKey('source')) { //if there is a key of source in our body map
						src = (Map<String, Object>)body.get('source'); //grab the value for the source key from the body map and cast it to a new map (String > primitive data types)
						if (src.containsKey('brand')) { //if there is a key of brand in our src map
							typeOfCard = (String)src.get('brand'); //grab the value for the brand key from the src map and cast it to a string
						}
						if (src.containsKey('last4')) { //if there is a key of last4 in our src map
							last4OfCard = (String)src.get('last4'); //grab the value for the last4 key from the src map and cast it to a string
						}
					}
					
					responseJSON.contactid = queriedContacts[0].Id; //populate the Id of the Contact record to our response object
					
					Task newTask = new Task(ActivityDate = Date.Today(), Description = 'The '+typeOfCard+' credit card ending in '+last4OfCard+' was charged.', Status = 'Complete', Subject = typeOfCard+' Card Charged', WhoId = queriedContacts[0].Id); //create a Task
					
					Database.SaveResult insertNewTask = Database.insert(newTask); //insert the new Task
					if (!insertNewTask.isSuccess()) { //if the insert DML was NOT successful
						List<Database.Error> errors = insertNewTask.getErrors(); //grab the error array from the SaveResult object
						//respond with failure
						responseJSON.status = 'failure';
						responseJSON.message = errors[0].getMessage(); //set the message to the first error in the array
					} else { //otherwise, the insert was successful
						responseJSON.taskid = insertNewTask.getId(); //populate the Id of the Task record to our response object
					}
				} else { //otherwise, no key of source in our map
					//respond with failure
					responseJSON.status = 'failure';
					responseJSON.message = 'There are no Contacts with the email address of '+emailAddress+'.';
				}
			} else { //otherwise, no key of description in our map
				//respond with failure
				responseJSON.status = 'failure';
				responseJSON.message = 'No description in the JSON request.';
			}
		} else { //otherwise, the JSON body was white space, empty ('') or null
			//respond with failure
			responseJSON.status = 'failure';
			responseJSON.message = 'Things basically broke...';
		}
		return responseJSON; //return the JSON response
	}
	
	//wrapper class for the response to an API request
	global class responseWrapper {
		
		global String status {get;set;} //status string
		global String contactid {get;set;} //18 character Contact record Id
		global String taskid {get;set;} //18 character Task record Id
		global String message {get;set;} //message string
		
		//constructor
		global responseWrapper() {
			//default all values
			this.status = 'success';
			this.contactid = '';
			this.taskid = '';
			this.message = '';
		}
	}

}
