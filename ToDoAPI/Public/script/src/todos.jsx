var React = require('react');
var ReactRouter = require('react-router');
var Link = ReactRouter.Link;
var TodoCheck = require('./todocheck.jsx');

var Todos = React.createClass({
    getInitialState: function() {
        return {
            data: [],
            source: "/todos"
        };
    },
    componentDidMount: function() {
        $.get(this.state.source, function(result) {
            if (this.isMounted()) {
                this.setState({
                    data: result
                });
            }
        }.bind(this));
    },
    render: function() {
        var createTodo = function(todo) {
            return (
                <li className="list-group-item" key={todo.id}>
                    <TodoCheck todo={todo}/>
                    <Link to={ "/" + todo.id }>{todo.title}</Link>
                </li>
            );
        };
        return (
            <div className="row">
            <h1>Todo</h1>
                <ul className="list-group">
                    {this.state.data.map(createTodo)}
                </ul>
            </div>
        );
    }
});

module.exports = Todos
