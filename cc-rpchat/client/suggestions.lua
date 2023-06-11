Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/ooc', 'Służy do wysyłania wiadomości OOC w okolicy.', {
      { name="treść", help="Wiadomość OOC" }
    })

    TriggerEvent('chat:addSuggestion', '/me', 'Służy do opisywania czynności, które wykonuje Twoja postać.', {
      { name="akcja", help="Czynność, którą wykonuje Twoja postać." }
    })

    TriggerEvent('chat:addSuggestion', '/do', 'Służy do opisywania akcji z trzeciej osoby.', {
      { name="akcja", help="Akcja, którą opisujesz z trzeciej osoby." }
    })
end)