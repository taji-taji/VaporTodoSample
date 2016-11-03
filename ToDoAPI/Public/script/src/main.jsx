var React = require('react');
var ReactDOM = require('react-dom');
var ReactRouter = require('react-router');
var Router = ReactRouter.Router;
var Route = ReactRouter.Route;
var IndexRoute = ReactRouter.IndexRoute;
var hashHistory = ReactRouter.hashHistory;
var Link = Router.Link;
var Todos = require('./todos.jsx');
var Todo = require('./todo.jsx');

// ReactDOM.render(
//     <Todos source="/todos" />,
//     document.getElementById('content')
// );

ReactDOM.render(
    <Router history={hashHistory}>
        <Route path="/" component={Todos}/>
        <Route path="/:todoId" name="/:todoId" component={Todo}/>
    </Router>,
    document.getElementById('content')
);