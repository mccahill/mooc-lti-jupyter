$(function(){
	$("#add_group_btn").click(function(e) {
		addMe();
	  e.stopPropagation();
		return false;
	 });
	$("#new_group").on('keydown',  function(e) {
    if (e.which == 13) {
			addMe();
		  e.stopPropagation();
			return false;
    }
	 });
	function addMe(){
		rowid = Date.now();
		newGroup = $('#new_group').val();
		var row = $("<tr>");
		row.attr("id",'tr_'+ rowid);
		inputBox = $('<input/>').attr({ 
			type: 'text',
			class: 'input-xxlarge',
			id: 'image_groups_attributes_'+rowid+'_urn', 
			name: 'image[groups_attributes]['+rowid+'][urn]',
			value: newGroup
		});
		row.append( $("<td>").append(inputBox));
		
		btn = $("<a>").text('Remove');
		btn.attr('href','#');
		btn.attr('class',"btn btn-default btn-delete");
		btn.attr('onclick', "return deleteGroup("+rowid+")");
		row.append( $("<td>").append(btn));	
		$("#group_table").append(row);
		$('#new_group').val('');
		showGroups();
		
	}
	showGroups();
});

function showGroups(){
	var rowCount = $('#group_table tr').length;
	if (rowCount > 1){
		$('#no_groups').hide();
		$('#got_groups').show();
	} else {
		$('#no_groups').show();
		$('#got_groups').hide();
	}
	
}

function deleteGroup(myIndex){
	$("#tr_" + myIndex).remove();
	showGroups();
	return false;
}
