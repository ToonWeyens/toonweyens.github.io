const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto("file://" + process.cwd() + "/" + "index.html");
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
