var React = require('react');

var TodoCheck = React.createClass({
    getInitialState: function() {
        return {
            source: "/todos/" + this.props.todo.id
        };
    },
    __changeSelection: function (todo) {
        todo.completed = true
        $.ajax({
            url: this.state.source,
            dataType: 'json',
            type: 'PUT',
            data: todo,
            success: function(data) {
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
        // var nextState = this.state.map(function (d) {
        //     return {
        //         id: d.id,
        //         selected: (d.id === id ? !d.selected: d.selected)
        //     };
        // });
        // console.log(nextState); // 確認用
        // this.setState( {data: nextState });
    },
    render: function() {
        console.log(this.props);
        return (
            <input type="checkbox" checked={this.props.todo.completed} onChange={this.__changeSelection.bind(this, this.props.todo, )}/> 
        );
    }
});

module.exports = TodoCheck
