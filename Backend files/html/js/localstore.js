
// check to see if browser supports localstorage
if (typeof(Storage)!=="undefined")
{    
	//alert('local storage works!')
    // save and get a course to shopping list
    function addHistory(_id, _title, _faculty, _department)
	{		
		// check to see if the value is in local storage
		if (localStorage.getItem("history")) 
		{
			//var shopping = [];
		    var history = JSON.parse(localStorage.getItem("history"));
		    var data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department,
		    	time : new Date()
		    }
		    history.push(data);
		    localStorage.setItem("history", JSON.stringify(history));
		    //alert('history added: ' + JSON.stringify(history));
	    }
	    // if not, initialize it
	    else 
	    {
	    	// you have to set this twice the first time for it to register
	    	var history = [];
	    	var data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department
		    }
		    history.push(data);
	    	localStorage.setItem("history", JSON.stringify(history));
	    	
		    history = JSON.parse(localStorage.getItem("history"));
		    data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department,
		    	time : new Date()
		    }
		    history.push(data);
		    localStorage.setItem("history", JSON.stringify(history));
	    }
	}
	
	function getHistory() 
	{
		// check to see if the value is in local storage
		if (localStorage.getItem("history")) 
		{
			// setup the list view
			var courseList = document.getElementById('courses');
			//alert('1')
			// store a record of the rows added so you can check for duplicates
			var addedCourses = []
			//alert('2')
			// get and iterate through results
			var history = JSON.parse(localStorage.getItem("history"));
	
			// iterate in reverse so you build the list in a more logical order
			for (i = history.length - 1; i > 0; i--)
			{
				//alert('4')
	            // filter out bad results
	            if (history[i].id && JSON.stringify(addedCourses).search(history[i].id) == -1) 
	        	{
	        		//alert('5')
	        		// store record
	        		addedCourses.push(history[i].id)
	        		//alert('6')
	        		// build the row
		            courseList.innerHTML = courseList.innerHTML + 
			            '<ul data-role="listview" data-inset="true">' + 
			            "<li><a href=/main/course/" + history[i].id + ">" + 
			                "<h3>" + history[i].title + "</h3>" + 
			                "<p><strong>" + history[i].faculty + "</strong></p>" + 
			                "<p>" + history[i].department + "</p>" +       
			            "</a></li></ul>";
	            }
	            else
	            {
	            	//alert('course skipped')
	            }
			}
		}
	}
	
	
    // save and get a list of saved courses
    function addSaved(_id, _title, _faculty, _department)
	{		
		// check to see if the value is in local storage
		if (localStorage.getItem("saved")) 
		{
			//alert('1')
			//var shopping = [];
		    var saved = JSON.parse(localStorage.getItem("saved"));
		    var data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department,
		    	time : new Date()
		    }
		    saved.push(data);
		    localStorage.setItem("saved", JSON.stringify(saved));
		    //alert('saved added: ' + JSON.stringify(saved));
	    }
	    // if not, initialize it
	    else 
	    {
	    	var saved = [];	    	
		    var data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department
		    }
	    	saved.push(data);
	    	localStorage.setItem("saved", JSON.stringify(saved));
	    	
	    	saved = JSON.parse(localStorage.getItem("saved"));	    	
		    data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department
		    }
	    	saved.push(data);
	    	localStorage.setItem("saved", JSON.stringify(saved));
	    }
	}
	
	function getSaved() 
	{
		// setup the list view
		var courseList = document.getElementById('courses');
		
		// store a record of the rows added so you can check for duplicates
		var addedCourses = []
		
		// get and iterate through results
		var saved = JSON.parse(localStorage.getItem("saved"));
		
		// iterate in reverse so you build the list in a more logical order
		for (i = saved.length - 1; i > 0; i--)
		{
            // filter out bad results
            if (saved[i].id && JSON.stringify(addedCourses).search(saved[i].id) == -1) 
        	{
        		// store record
        		addedCourses.push(saved[i].id)
        		
        		// build the row
	            courseList.innerHTML = courseList.innerHTML + 
		            '<ul data-role="listview" data-inset="true">' + 
		            "<li><a href=/main/course/" + saved[i].id + ">" + 
		                "<h3>" + saved[i].title + "</h3>" + 
		                "<p><strong>" + saved[i].faculty + "</strong></p>" + 
		                "<p>" + saved[i].department + "</p>" +       
		            "</a></li></ul>";
            }
            else
            {
            	//alert('course skipped')
            }
		}
	}
	
	
    // save and get a list of courses added to schedule
    function addSchedule(_id, _title, _faculty, _department)
	{
		// check to see if the value is in local storage
		if (localStorage.getItem("schedule")) 
		{
			//var shopping = [];
		    var schedule = JSON.parse(localStorage.getItem("schedule"));
		    var data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department,
		    	time : new Date()
		    }
		    schedule.push(data);
		    localStorage.setItem("schedule", JSON.stringify(schedule));
		    //alert('schedule added: ' + JSON.stringify(schedule));
	    }
	    // if not, initialize it
	    else 
	    {
	    	//alert('else');
	    	var schedule = [];	    	
		    var data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department
		    }
	    	schedule.push(data);
	    	localStorage.setItem("schedule", JSON.stringify(schedule));
	    	
	    	schedule = JSON.parse(localStorage.getItem("schedule"));	    	
		    data = {
		    	id : _id,
		    	title : _title,
		    	faculty : _faculty,
		    	department : _department
		    }
	    	schedule.push(data);
	    	localStorage.setItem("schedule", JSON.stringify(schedule));	    	
	    }
	}
	
	function getSchedule() 
	{
		// setup the list view
		var courseList = document.getElementById('courses');
		
		// store a record of the rows added so you can check for duplicates
		var addedCourses = []
		
		// get and iterate through results
		var schedule = JSON.parse(localStorage.getItem("schedule"));
		
		// iterate in reverse so you build the list in a more logical order
		for (i = schedule.length - 1; i > 0; i--)
		{
            // filter out bad results
            if (schedule[i].id && JSON.stringify(addedCourses).search(schedule[i].id) == -1) 
        	{
        		// store record
        		addedCourses.push(schedule[i].id)
        		
        		// build the row
	            courseList.innerHTML = courseList.innerHTML + 
		            '<ul data-role="listview" data-inset="true">' + 
		            "<li><a href=/main/course/" + schedule[i].id + ">" + 
		                "<h3>" + schedule[i].title + "</h3>" + 
		                "<p><strong>" + schedule[i].faculty + "</strong></p>" + 
		                "<p>" + schedule[i].department + "</p>" +       
		            "</a></li></ul>";
            }
            else
            {
            	//alert('course skipped')
            }
		}
	}		
}
else
{
    alert('Sorry, your browser does not support saving a schedule')
}