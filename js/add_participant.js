document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('addParticipantForm');
    
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const formData = new FormData(form);
        const data = Object.fromEntries(formData.entries());

        try {
            const response = await fetch('../api/add_participant.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });

            // Проверяем, что ответ - JSON
            const text = await response.text();
            let result;
            try {
                result = JSON.parse(text);
            } catch {
                throw new Error(`Сервер вернул не JSON: ${text}`);
            }

            if (!response.ok || !result.success) {
                throw new Error(result.message || 'Неизвестная ошибка');
            }

            alert('Участник добавлен! ID: ' + result.participant_id);
            form.reset();
        } catch (error) {
            console.error('Ошибка:', error);
            alert(error.message);
        }
    });
});