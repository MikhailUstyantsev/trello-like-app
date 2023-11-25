# trello-like-app

Данный проект иллюстрирует Drag and Drop (перетаскивание) API в iOS. 

Благодаря такой технологии, пользователи могут перетаскивать элементы из одного места на экране в другое, используя непрерывные жесты. Действие перетаскивания может происходить в одном приложении или может начинаться в одном приложении и заканчиваться в другом. 

Это можно применить, если нам нужен проект, где пользователь может передвигать данные по экрану (как например в Jira, Trello или других проектах, где записи перекидываются между досками).

Вся магия происходит при реализации методов UITableViewDragDelegate и UITableViewDropDelegate. Схема данного приложения представлена на слайде.
_____________

This project illustrates the Drag and Drop API in iOS.

With this technology, users can drag and drop elements from one location on the screen to another using continuous gestures. The drag-and-drop action can happen in one application, or it can start in one application and end in another.

This can be applied if we need a project where the user can move data around the screen (such as in Jira, Trello or other projects where posts are transferred between boards).

All the magic happens when implementing the UITableViewDragDelegate and UITableViewDropDelegate methods. The diagram of this application is presented on the slide.


<p align="center">
  <img src="https://github.com/MikhailUstyantsev/trello-like-app/blob/main/Application%20Flow%20Diagram.png" alt="Application Flow Diagram"/>
</p>

<div align="center">
  <img src="https://github.com/MikhailUstyantsev/trello-like-app/blob/main/Trello-like%20App.mp4"/>
</div>

<p align="center">
  User Interface demo
</p>
