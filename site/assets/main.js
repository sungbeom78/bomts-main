document.querySelectorAll('[data-year]').forEach((node) => { node.textContent = String(new Date().getFullYear()); });

async function addLocalManual() {
  try {
    const response = await fetch('/local/context.json', {
      cache: 'no-store',
      credentials: 'same-origin',
    });
    if (!response.ok) return;

    const context = await response.json();
    if (!context.local) return;

    document.querySelectorAll('.site-header nav').forEach((nav) => {
      if (nav.querySelector('[data-local-manual]')) return;

      const language = nav.querySelector('.language');
      const links = [
        ['매뉴얼', context.manual],
        ['관리', context.admin],
      ];

      links.forEach(([label, href]) => {
        const link = document.createElement('a');
        link.href = href;
        link.textContent = label;
        link.className = 'local-manual';
        link.dataset.localManual = 'true';
        nav.insertBefore(link, language);
      });
    });
  } catch (_error) {
    // Public requests intentionally receive no internal context.
  }
}

addLocalManual();
