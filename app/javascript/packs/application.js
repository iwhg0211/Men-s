// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

import Raty from "raty.js"
//ratyのバージョンが４になってからimportで呼び出すようになった
//あとバージョン４でjqueryで呼び出さなくなった
//javascript直下で呼び出す時はこの「import Raty from "..."」という記述
window.raty = function(elem, opt) {
  //window.ratyでどこでも(elem, opt)みたいな引数を呼び出すことができるようになる
  var raty = new Raty(elem, opt)//new ratyで初期化
  raty.init();
  return raty;//return ratyで初期化したものを呼び出し
}

//console.log('check');
//↑railsでいうところのbinding.pryやbyebugにあたるもの。
//28業目に記述しておくと、アプリの検証画面(macはcommand+control+i)のconsoleの部分で表示がある。28行目までうまくいってたらcheckと表示され、ダメだったらエラーが出る。
//javascript系でエラーが出るときは、ディレクトリの場所がおかしかったり、そもそも読み込めていないときは、ターミナルにエラーが出るし、
//読み込めていても、何らかのエラーが出ていたら、アプリの検証画面でエラーが出る


Rails.start()
Turbolinks.start()
ActiveStorage.start()