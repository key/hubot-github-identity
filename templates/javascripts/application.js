// Public: The main entry point to the frontend application.
window.App = {
  username: null,
  token: null,

  init: function() {
    this.commandbar = new window.CommandBarView;
    this.replies = new window.RepliesView;
  },

  request: function(url, data, callback) {
    $.ajax(url, {
      type: 'POST',
      data: data,
      success: function(data)  {
        callback(null, data);
      },
      error: function(xhr, status, err) {
        callback(err, null);
      },
    });
  },

  submitUsername: function(username) {
    var data = {
      username: username,
    };

    var self = this;
    var callback = function(err, data) {
      if (err) {
        console.log(err);
      }
      else {
        console.log(data);
      }
    };

    this.request('/github/identity/username', data, callback);
  },

  submitToken: function(token) {
    var data = {
      username: this.username,
      token: token,
    };

    var self = this;
    var callback = function(err, data) {
      if (err) {
        console.log(err);
      }
      else {
        console.log(data);
      }
    };

    this.request('/github/identity/token', data, callback);
  },
};

// Internal: The view for handling replies from hubot.
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

// Internal: The view for handling a single reply from hubot.
window.ReplyView = Backbone.View.extend({
  tagName: 'h1',

  initialize: function(options) {
    this.template = _.template($(options.template).html());
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },
});

// Internal: The view for handling the command bar input.
window.CommandBarView = Backbone.View.extend({
  el: '.js-command-bar',

  events: {
    'keypress .js-command-input': 'submit',
  },

  initialize: function() {
    this.commandinput = this.$('.js-command-input');
    this.commandinput.focus();
  },

  submit: function(e) {
    if (e.keyCode != 13) return;
    if (!this.commandinput.val()) return;

    var input = this.commandinput.val();
    this.commandinput.val('');

    if (!window.App.username && !window.App.token) {
      // step 1: we need the github username
    }
    else if (window.App.username && !window.App.token) {
      // step 2: we need the github api token
    }
    else if (window.App.username && window.App.token) {
      // step 3: we're done
    }
  },
});
