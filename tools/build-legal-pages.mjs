// Builds static HTML for Play Console from the in-app Markdown policies.
// Usage: node tools/build-legal-pages.mjs   (writes hosting/privacy/**, hosting/delete-account/index.html)
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';

const esc = (s) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
const inline = (s) => esc(s).replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>');

function md(src) {
  const out = [];
  let list = false;
  const close = () => { if (list) { out.push('</ul>'); list = false; } };
  for (const raw of src.split('\n')) {
    const line = raw.trimEnd();
    let m;
    if (!line.trim()) { close(); continue; }
    if (line.trim() === '---') { close(); out.push('<hr>'); continue; }
    if ((m = line.match(/^(#{1,3})\s+(.*)$/))) { close(); out.push(`<h${m[1].length}>${inline(m[2])}</h${m[1].length}>`); continue; }
    if ((m = line.match(/^-\s+(.*)$/))) { if (!list) { out.push('<ul>'); list = true; } out.push(`<li>${inline(m[1])}</li>`); continue; }
    close();
    out.push(`<p>${inline(line)}</p>`);
  }
  close();
  return out.join('\n');
}

const page = (lang, dir, title, body) => `<!doctype html>
<html lang="${lang}" dir="${dir}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<style>
:root{color-scheme:light dark}
body{font:16px/1.7 system-ui,-apple-system,"Segoe UI",Tahoma,sans-serif;max-width:760px;margin:0 auto;padding:24px 16px 64px}
h1{font-size:1.7rem}h2{font-size:1.25rem;margin-top:2rem}h3{font-size:1.05rem}
hr{border:0;border-top:1px solid #8884;margin:1.5rem 0}
a{color:#2563eb}
nav{display:flex;gap:16px;margin-bottom:24px}
</style>
</head>
<body>
${body}
</body>
</html>
`;

for (const [lang, dir, file, outDir] of [
  ['en', 'ltr', 'assets/md_files/privacy_policy_en.md', 'hosting/privacy'],
  ['ar', 'rtl', 'assets/md_files/privacy_policy_ar.md', 'hosting/privacy/ar'],
]) {
  const src = readFileSync(file, 'utf8');
  const title = src.split('\n')[0].replace(/^#\s+/, '');
  mkdirSync(outDir, { recursive: true });
  const nav = lang === 'en' ? '<nav><a href="/privacy/ar/">العربية</a></nav>' : '<nav><a href="/privacy/">English</a></nav>';
  writeFileSync(`${outDir}/index.html`, page(lang, dir, title, nav + md(src)));
}

const deletion = `<nav><a href="#ar">العربية</a></nav>
<h1>Delete your Falih account</h1>
<p>You can delete your Falih account and its data at any time.</p>
<h2>In the app (fastest)</h2>
<ol><li>Open Falih and sign in.</li><li>Go to <strong>Settings → Account → Delete account</strong>.</li><li>Enter your password and confirm.</li></ol>
<p>This permanently deletes your profile, exam history, notifications, profile photo and sign-in account. It cannot be undone. Some derived data, such as the monthly leaderboard, may keep showing your entry until it is next recalculated.</p>
<h2>If you cannot open the app</h2>
<p>Email <a href="mailto:falihTeam@gmail.com">falihTeam@gmail.com</a> with the phone number and username of the account. We may ask you to prove the account is yours before deleting it.</p>
<p>See our <a href="/privacy/">Privacy Policy</a>.</p>
<hr>
<div id="ar" dir="rtl" lang="ar">
<h1>حذف حسابك في فالح</h1>
<p>يمكنك حذف حسابك وبياناتك في أي وقت.</p>
<h2>من داخل التطبيق (الأسرع)</h2>
<ol><li>افتح فالح وسجّل الدخول.</li><li>اذهب إلى <strong>الإعدادات ← الحساب ← حذف الحساب</strong>.</li><li>أدخل كلمة المرور وأكّد.</li></ol>
<p>يؤدي ذلك إلى حذف ملفك الشخصي وسجل اختباراتك والإشعارات وصورتك وحساب الدخول نهائيًا، ولا يمكن التراجع عنه. وقد تستمر بعض البيانات المشتقة، مثل لوحة المتصدرين الشهرية، في إظهار اسمك إلى حين إعادة احتسابها.</p>
<h2>إذا تعذّر عليك فتح التطبيق</h2>
<p>راسلنا على <a href="mailto:falihTeam@gmail.com">falihTeam@gmail.com</a> برقم الهاتف واسم المستخدم الخاصين بالحساب. قد نطلب منك إثبات ملكيتك للحساب قبل حذفه.</p>
<p>اطّلع على <a href="/privacy/ar/">سياسة الخصوصية</a>.</p>
</div>`;
mkdirSync('hosting/delete-account', { recursive: true });
writeFileSync('hosting/delete-account/index.html', page('en', 'ltr', 'Delete your Falih account', deletion));
