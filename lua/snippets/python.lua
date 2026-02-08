local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

return {
  s({ trig = 'SUBPLOTS', wordTrig = true, snippetType = 'autosnippet' }, {
    t {
      'x = np.linspace(0, 1, 50)',
      '',
      'y1 = x**2',
      'y2 = np.sqrt(x)',
      'y3 = x',
      'y4 = x**3',
      '',
      'fig, axs = plt.subplots(',
      '\tnrows=2,',
      '\tncols=2,',
      '\tfigsize=(10, 8)  # width, height',
      ')',
      '',
      'fig.suptitle("General title for the figure")',
      '',
      'axs[0, 0].plot(x, y1)',
      'axs[0, 0].set_ylabel("squared")',
      'axs[0, 0].set_title("top left")',
      '',
      'axs[0, 1].plot(x, y2, color="orange")',
      'axs[0, 1].set_ylabel("root")',
      'axs[0, 1].set_title("top right")',
      '',
      'axs[1, 0].plot(x, y3, color="red")',
      'axs[1, 0].set_ylabel("identity")',
      'axs[1, 0].set_title("bottom left")',
      '',
      'axs[1, 1].plot(x, y4, color="black")',
      'axs[1, 1].set_ylabel("cube")',
      'axs[1, 1].set_title("bottom right")',
      '',
      'plt.show()',
    },
  }),
}
