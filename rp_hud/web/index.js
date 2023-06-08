let oldRight = 0;

window.addEventListener("message", (event) => {
  if (document.readyState === "complete" || document.readyState === "loaded") {
    if (event.data.state == "showPlayerHud") {
      if (event.data.properties) {
        document.getElementsByClassName("firstName")[0].innerHTML = event.data.properties.firstName;
        document.getElementsByClassName("lastName")[0].innerHTML = event.data.properties.lastName;
      }

      document.getElementsByClassName("container")[0].style.visibility = (event.data.show === true) ? "visible" : "hidden";
    }

    if (event.data.state == "showVoiceIndicator") {
      document.getElementsByClassName("waves")[0].style.visibility = "visible";
    }

    if (event.data.state == "hideVoiceIndicator") {
      document.getElementsByClassName("waves")[0].style.visibility = "hidden";
    }

    if (event.data.state == "updatePlayerDataInHud") {
      let direction = event.data.properties.direction;
      let streetName = event.data.properties.street;
      let zoneName = event.data.properties.zone;

      document.getElementsByClassName("direction")[0].innerHTML = direction;
      document.getElementsByClassName("streetName")[0].innerHTML = streetName;
      document.getElementsByClassName("zoneName")[0].innerHTML = zoneName;
    }

    if (event.data.state == "updateVoiceDistanceInHud") {
      let distance = event.data.properties.distance;

      document.getElementsByClassName("distance")[0].innerHTML = distance;
    }

    if (event.data.state == "updateMinimapPosition") {
      let right;

      let isWide = event.data.properties.isWide;

      if (isWide == false) {
        right = (event.data.properties.position * 1000) - 101;
      } else {
        right = (event.data.properties.position * 1000) - 151;
      }
      
      if (oldRight !== right) {
        oldRight = right; 

        document.getElementsByClassName("voice")[0].style.left = ``;
        document.getElementsByClassName("status")[0].style.left = ``;

        let voiceLeft = document.getElementsByClassName("voice")[0].offsetLeft;
        let statusLeft = document.getElementsByClassName("status")[0].offsetLeft;

        document.getElementsByClassName("voice")[0].style.left = `${voiceLeft + right}px`;
        document.getElementsByClassName("status")[0].style.left = `${statusLeft + right}px`;
      }
    }
  }
});