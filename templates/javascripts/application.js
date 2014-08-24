window.App = {
  init: function() {
    this.appView = new window.AppView;
  },
};

window.AppView = Backbone.View.extend({
  initialize: function() {
    this.commandbar = new window.CommandBarView;
  },
});

window.RepliesView = Backbone.View.extend({
  el: '.js-replies',

  add: function(reply) {
    this.$el.append(reply.render().el);
  },

  fadePrevious: function() {
    this.$('h1')
      .css('opacity', '.2')
      .css('border-right', '0')
      .css('-webkit-animation', 'none')
      .css('-moz-animation', 'none');
  },
});

window.ReplyView = Backbone.View.extend({
  tagName: 'h1',

  initialize: function(options) {
    this.template = _.template($(options.template).html());
  },

  render: function() {
    this.$el.html(this.template());
    console.log(this.$el);
    return this;
  },
});

window.CommandBarView = Backbone.View.extend({
  el: '.js-command-bar',

  events: {
    'keypress .js-command-input': 'submit',
  },

  initialize: function() {
    this.commandinput = this.$('.js-command-input');
    this.commandinput.focus();

    this.replies = new window.RepliesView;
  },

  submit: function(e) {
    if (e.keyCode != 13) return;
    if (!this.commandinput.val()) return;

    var reply = new window.ReplyView({ template: '#user-success' });
    this.replies.fadePrevious();
    this.replies.add(reply);
    this.commandinput.val('');
  },
});
