function openModal(id) {
    $('#' + id).removeClass('closed').addClass('open');
}

function closeModal(id){
    $('#' + id).removeClass('open').addClass('closed');
}
