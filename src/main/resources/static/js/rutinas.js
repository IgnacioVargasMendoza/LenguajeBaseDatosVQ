// Función para limpiar el backdrop del modal
function limpiarBackdrop() {
    setTimeout(function() {
        // Remover manualmente el backdrop y restaurar el desplazamiento
        const backdrops = document.getElementsByClassName('modal-backdrop');
        while(backdrops.length > 0) {
            backdrops[0].parentNode.removeChild(backdrops[0]);
        }
        document.body.classList.remove('modal-open');
        document.body.style.overflow = '';
        document.body.style.paddingRight = '';
    }, 200);
}

// Agregar manejadores de eventos a todos los modales cuando el DOM esté cargado
document.addEventListener('DOMContentLoaded', function() {
    // Buscar todos los modales en la página
    const modales = document.querySelectorAll('.modal');
    
    // Para cada modal, agregar un evento para cuando se oculta
    modales.forEach(function(modal) {
        modal.addEventListener('hidden.bs.modal', function() {
            limpiarBackdrop();
        });
    });

    // Buscar todos los botones que cierran modales
    const botonesCloseModal = document.querySelectorAll('[data-bs-dismiss="modal"]');
    
    // Para cada botón, agregar un evento para cuando se hace clic
    botonesCloseModal.forEach(function(boton) {
        boton.addEventListener('click', function() {
            limpiarBackdrop();
        });
    });
}); 