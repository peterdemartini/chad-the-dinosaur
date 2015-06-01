React = require 'react'
Router = require 'react-router'
{ Redirect, Route, RouteHandler, Link, DefaultRoute, NotFoundRoute } = Router

App = require './app'
Game = require './components/game'

routes =
  <Route handler={App} path="/">
    <DefaultRoute handler={Game} />
    <NotFoundRoute handler={Game}/>
  </Route>


Router.run routes, (Handler) ->
  React.render(<Handler/>, document.getElementById('app'))
