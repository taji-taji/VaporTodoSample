var React = require('react');
var ReactRouter = require('react-router');
var Link = ReactRouter.Link;

var Todo = React.createClass({
    getInitialState: function() {
        return {
            data: [],
            source: "/todos/" + this.props.params.todoId
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
        return (
            <div className="row">
                <h1>{this.state.data.title}</h1>
                <Link to={ "/" }>戻る</Link>
            </div>
        );
    }
});

module.exports = Todo
