document.addEventListener('DOMContentLoaded', () => {
    const table = $('#participantsTable').DataTable({
        ajax: {
            url: '../api/get_participants.php',
            dataSrc: '',
            error: function(xhr) {
                console.error('Ошибка загрузки данных:', xhr.responseText);
                alert('Не удалось загрузить данные. Проверьте консоль для деталей.');
            }
        },
        columns: [
            { data: 'id' },
            { data: 'last_name' },
            { data: 'first_name' },
            { data: 'weight_category' },
            { 
                data: 'contact_phone',
                render: function(phone) {
                    return phone.replace(/^(\d{1})(\d{3})(\d{3})(\d{2})(\d{2})$/, '+$1 ($2) $3-$4-$5');
                }
            },
            { 
                data: 'registration_date',
                render: function(date) {
                    return new Date(date).toLocaleString('ru-RU');
                }
            }
        ],
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.11.5/i18n/ru.json'
        }
    });

    // Кнопка обновления таблицы
    $('#refreshBtn').on('click', function() {
        table.ajax.reload();
    });
});