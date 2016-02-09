function openModal(id) {
    $('#' + id).removeClass('closed');
    $('#' + id).addClass('open');
}

function closeModal(id){
    $('#' + id).removeClass('open');
}
