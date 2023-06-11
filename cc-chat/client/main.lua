function getTimestamp()
    local year, month, day, hour, minute, second = GetLocalTime()

    local formattedHour = string.format("%02d", hour)
    local formattedMinute = string.format("%02d", minute)

    local timestamp = formattedHour .. ':' .. formattedMinute
    return timestamp
end

exports('getTimestamp', getTimestamp)