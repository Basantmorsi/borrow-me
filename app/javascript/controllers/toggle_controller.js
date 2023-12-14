import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "cards", "edit", "editCard", "profileLink"]

  connect() {

    let chatListHeader = document.querySelectorAll("#chatConversations");
    let totalHeight = 0;

    for(let i = 0; i < chatListHeader.length; i++){
      let totalHeight = 0;
      chatListHeader[i].addEventListener("click", function(){
        let result = this.nextElementSibling;
        let activeSibling = this.nextElementSibling.classList.contains('active');
        this.classList.toggle('active');
        result.classList.toggle("active");
        if(!activeSibling) {
          for( i= 0; i < result.children.length; i++) {
            totalHeight = totalHeight +  result.children[i].scrollHeight + 40;
          }
        } else {
          totalHeight = 0;
        }
        result.style.maxHeight =  totalHeight + "px";
      });

      }

  }

  toggleEdit(event) {
    const url = new Request(event.target.dataset.toggleUrl);
    console.log(event.target.dataset.toggleFinder)
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.editCardTarget.innerHTML = data;
        this.toggleVisibility(); // Toggle visibility after updating content
      })
  }


  profile(event)
  {
      event.preventDefault()
      // event.stopPropagation()
      console.log(event.target.dataset.toggleUrl)
      const url = new Request(this.profileLinkTarget.href);

    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.cardsTarget.innerHTML = data;
      })
    //this.cardsTarget.append("<%= j render(:partial => 'devise/registrations/edit') %>");


  }

  toggleVisibility() {
    this.editCardTarget.classList.toggle('d-none');
  }

  toggle(event) {


    event.preventDefault()




    // const selected = document.querySelector('.selected');
    // if (selected !== null) {
    //   selected.classList.toggle('selected');
    // }
    // event.target.classList.toggle('selected');

    const url = new Request(event.target.dataset.toggleUrl);

    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.cardsTarget.innerHTML = data;
        //this.toggleVisibility(); // Toggle visibility after updating content
      })
  }

    activeChat(event){

     const chatlistitem = document.querySelectorAll(".chat-list-item");
     for(let i = 0; i < chatlistitem.length; i++){
       chatlistitem[i].className = "chat-list-item"
      //  chatlistitem[i].classList.remove('active')
     }
    //  if (!$(event.target).is('img')){
    // }
    const tabItem = document.querySelectorAll(".chat-list-header");
    for(let i = 0; i < tabItem.length; i++){
      tabItem[i].className = "chat-list-header"
    }
    event.target.className = "chat-list-item active";
     //event.parentNode.classList.add("active")

    }

    activeTab(event){
      const tabItem = document.querySelectorAll(".chat-list-header");
      for(let i = 0; i < tabItem.length; i++){
        tabItem[i].className = "chat-list-header"
      }
      // if (!$(event.target).is('img')){
      // }
      const chatlistitem = document.querySelectorAll(".chat-list-item");
     for(let i = 0; i < chatlistitem.length; i++){
       chatlistitem[i].className = "chat-list-item"
      //  chatlistitem[i].classList.remove('active')
     }
      event.target.className = "chat-list-header activetab";
      //event.parentNode.classList.add("activetab")
      // event.parentNode.className = "chat-list-header activetab";

    }

    deactivateChat(event){
      const tabItem = document.querySelectorAll(".chat-list-header");
      for(let i = 0; i < tabItem.length; i++){
        tabItem[i].className = "chat-list-header"
      }
    }

  fetchContent(request) {
    fetch(request)
      .then((response) => {
        if (response.status == 200) {
          response.text().then((text) => {
            this.cardsTarget.innerHTML = text;
            this.toggleVisibility(); // Toggle visibility after updating content
          });
        } else {
          console.log("Couldn't load data");
        }
      })
  }

  toggleModify(event) {
    console.log(event.target.dataset.toggleFinder)
    const target = document.getElementById(event.target.dataset.toggleFinder)
    target.classList.toggle("d-none")
  }
}
