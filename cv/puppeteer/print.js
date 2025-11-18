const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  // Need to use wait, from https://github.com/puppeteer/puppeteer/issues/1875#issuecomment-359448297
  await page.goto("file://" + process.cwd() + "/" + "index.html", {
    waitUntil:['domcontentloaded', 'networkidle0']
});
  await page.emulateMediaType('screen');
  await page.pdf({
    path: "CV_ToonWeyens.pdf",
    format: "A4",
    printBackground: true,
    displayHeaderFooter: false,
    margin: { top: "1cm", bottom: "1cm", left: "1cm", right: "1cm" }
  });
  await page.close();

  await browser.close();
})();
