import { event } from "jquery";

const tabActive = () => {
  if (document.querySelectorAll(".tab-item")){
    const tabs = document.querySelectorAll(".tab-item");
    tabs.forEach(tab => {
      tab.addEventListener("click", event => {
        event.currentTarget.classList.toggle("active")
      })
    })
  }
}

export {tabActive}
