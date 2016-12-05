# 編集中

# react とは
MVCで言うところの
Viewの実装に特化したライブラリ

### 何が嬉しいの？
1. シンプル(利用が容易)である
2. Virtual DOMによるレンダリング効率の向上
3. コンポーネント指向で保守性、可読性が高い


### 注意点
jquery とreact は同じview 内で使わない

# react を理解する5つのキーワード
1. コンポーネント
根幹
定義し、配置していくもの
2. ステート
コンポーネントの内部変数のようなもの
3. プロパティ
コンポーネントに外部から与えられるオプションのようなもの
4. JSX
javascriptの中でXMLの文法によって
reactのコンポーネントを配置できるようにするための一種の言語
5. 仮想DOM

# サンプルソース
### html
```
<script src="https://fb.me/react-15.3.0.js"></script>
<script src="https://fb.me/react-dom-15.3.0.js"></script>

<div id="content"></div>
```

### react
```
// カスタムコンポーネントを定義
var Evaluator = React.createClass({
  // ステートを初期化するgetInitialStateメソッド
  getInitialState: function() {
    return {
      // expressionステートの値を空の文字列に初期化
      expression: ''
    };
  },
  // ユーザー入力があると呼ばれるメソッド
  reCalcValue: function(e) {
    // 押されたキーが「Enter」のときだけ以下の処理を実行
    if (e.key === 'Enter')
      // this.setStateメソッドによってステートの値を変更する
      this.setState({
        // 入力された値(文字列)をexpressionステートにセット
        expression: e.target.value
      });
  },
  // renderを含む事によりコンポーネントとして成立する
  render: function() {
    return React.DOM.div(
      null,
      React.DOM.input({
        type: 'text',
        // inputの中でキーが押されたらreCalcValueを呼ぶようセット
        onKeyPress: this.reCalcValue
      }),
      // h2要素にexpressionステートの評価結果を書き込む
      React.DOM.h2(null, eval(this.state.expression))
    );
  }
});

// 定義されたコンポーネントからReactの要素を作成してhtml要素としてwebページに貼り付ける
ReactDOM.render(
  // createElementメソッドにカスタムコンポーネントを指定して要素を作成
  React.createElement(Evaluator),
  // htmlを書き込む場所をidで指定
  document.getElementById('content')
);
```

