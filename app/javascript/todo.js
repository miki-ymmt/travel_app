console.log('Script loaded'); // スクリプトが読み込まれたことを確認

document.addEventListener('turbo:load', () => {  // turbo:load イベントを監視
  console.log('turbo:load event fired'); // イベントが発生したことを確認
  document.querySelectorAll('input[type="checkbox"][name="todo[done]"]').forEach((checkbox) => { // チェックボックスを取得
    console.log('Adding event listener to checkbox'); // コンソールログを追加
    checkbox.addEventListener('change', (event) => { // チェックボックスの変更を監視
      console.log(`Checkbox changed: ${event.target.checked}`); // コンソールログを追加
      checkbox.closest('form').requestSubmit(); // フォームを送信
    });
  });
});