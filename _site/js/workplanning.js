function renderHeader(planning){
	var tr = $("#workplanning-table tr:first");
	planning.shifts.forEach(function(shift) {
		var start = new Date(Date.parse(shift.workStartsOn));
		var end = new Date(Date.parse(shift.workEndsOn));
		var div = $.template("#shift-template",
		{
			title: start.toLocaleDateString('nl-BE', { year: 'numeric', month: 'numeric', day: 'numeric' }) + " [" + start.toLocaleTimeString('nl-BE', { hour: 'numeric', minute: 'numeric' }) + "-" + end.toLocaleTimeString('nl-BE', { hour: 'numeric', minute: 'numeric' }) + "]"
		});
		tr.append($("<th>").addClass("responsive-table-cell").append(div));
		
	});
}

function renderRows(planning){
	planning.tasks.forEach(function(task) {
		var table = $("#workplanning-table");
		var div = $.template("#task-template",
		{
			description: task.description
		});
		var tr = $("<tr>");
		table.append(tr.append($("<td>").addClass("responsive-table-cell").append(div)));
		for (i = 0; i < planning.shifts.length; i++) {
			var shift = planning.shifts[i];
			var slots = planning.slots.filter(function(e){ return e.workTaskId === task.id && e.workShiftId == shift.id; });
			var slot = slots.length > 0 ? slots[0] : null;
			var slotid = task.id + "-" + shift.id;
			
			var content = renderSlotContent(task.id, shift.id, slot);					
			
			tr.append($("<td>").attr('id', slotid).addClass("responsive-table-cell").append(content));
		}
		
	});
}
function renderSlotContent(taskid, shiftid, slot){
	var allocated = slot != null ? slot.allocations.length : 0;
	var content = $.template("#allocation-template",
	{
		shiftid: shiftid,
		taskid: taskid,
		indicator: slot != null && slot.minimumStaffRequired > 0 ? allocated + "/" + slot.minimumStaffRequired : ""
	});
	if(slot != null){
		if(allocated < slot.minimumStaffRequired) content.find(".table-indicator").addBack('.table-indicator').addClass("red");
		var allocationlist = content.find(".allocated-list");
		slot.allocations.forEach(function(allocation){
			allocationlist.append($("<li>").append(allocation.name));
		});
		
	}
	return content;
}


$(document).ready(function(){
   
   var id = $("#workplanning").attr('data-id')
   var service = "community-service.azurewebsites.net";
   //var service = "localhost:22465"; // uncomment for local testing
   var uri= "http://" + service + "/api/workplanning/" + id;

   $.ajax({
        type: 'GET',
        url: uri,
        dataType: 'json', 
        crossDomain: true, 
        success: function(p){   
		    planning = p;
			renderHeader(planning);
			renderRows(planning);	
        }
      });
});

var planning;