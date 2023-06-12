Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/me', 'Służy do opisywania czynności, które wykonuje Twoja postać.', {
      { name="czynność", help="Czynność, którą wykonuje Twoja postać." }
    })

    TriggerEvent('chat:addSuggestion', '/do', 'Służy do opisywania akcji z trzeciej osoby.', {
      { name="akcja", help="Akcja, którą opisujesz z trzeciej osoby." }
    })

    TriggerEvent('chat:addSuggestion', '/try', 'Służy do opisywania czynności z szansą ną powodzenie (50%).', {
      { name="czynność", help="Czynność, którą próbuje wykonać Twoja postać." }
    })
end)