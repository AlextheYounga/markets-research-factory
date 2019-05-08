
Url.destroy_all
Url.create([
    {
        slug: "/inflation-cpi",
    },
    {
        slug: "/corporate-tax-rate",
    },
    {
        slug: "/interest-rate",
    },
    {
        slug: "/unemployment-rate",
    },
    {
        slug: "/personal-income-tax-rate",
    },
    {
        slug: "/gdp-per-capita",
    },
    {
        slug: "/government-debt-to-gdp",
    },
    {
        slug: "/banks-balance-sheet",
    },
    {
        slug: "/central-bank-balance-sheet",
    },
    {
        slug: "/government-budget-value",
    }
]);