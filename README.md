<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="ClearedJobs Scraper API by Piloterr – scrape ClearedJobs data as JSON" width="100%"></a>
</p>

# ClearedJobs Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr ClearedJobs Scraper API** lets you extract public data from ClearedJobs as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **ClearedJobs Job API** — Fetch one cleared job by its URL or by a slug that ends in the numeric id.
- **ClearedJobs Search API** — Search cleared jobs by keyword.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [ClearedJobs Job API](#clearedjobs-job-api) | `/v2/clearedjobs/job` | 1 | Fetch one cleared job by its URL or by a slug that ends in the numeric id. |
| [ClearedJobs Search API](#clearedjobs-search-api) | `/v2/clearedjobs/search` | 1 | Search cleared jobs by keyword. Only the first HTML page is available, so pagination.next is null and page 2 returns 404. |

## Table of contents

- [How it works](#how-it-works)
- [ClearedJobs Job API](#clearedjobs-job-api)
- [ClearedJobs Search API](#clearedjobs-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## ClearedJobs Job API

Fetch one cleared job by its URL or by a slug that ends in the numeric id.

`GET | POST https://api.piloterr.com/v2/clearedjobs/job` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Job URL or slug ending in the numeric id. Example: analyst-washington-district-of-columbia-1902823. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/clearedjobs/job",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "analyst-washington-district-of-columbia-1902823.",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ClearedjobsJob = {
  id?: string;
  url?: string;
  city?: string;
  title?: string;
  region?: string;
  company?: string;
  country?: string;
  location?: string;
  company_url?: string;
  date_posted?: string;
  description?: string;
  postal_code?: string;
  company_logo?: string;
  valid_through?: string;
  employment_type?: string;
  security_clearance?: string;
};

const params = new URLSearchParams({
  "query": "analyst-washington-district-of-columbia-1902823.",
});

const response = await fetch(`https://api.piloterr.com/v2/clearedjobs/job?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ClearedjobsJob;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/clearedjobs/job
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "analyst-washington-district-of-columbia-1902823."}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "1902823",
  "url": "https://clearedjobs.net/job/analyst-washington-district-of-columbia-1902823",
  "city": "Washington",
  "title": "Analyst",
  "region": "District of Columbia",
  "company": "Koniag Government Services",
  "country": "United States",
  "location": "Washington, District of Columbia, United States",
  "company_url": "https://clearedjobs.net/company/koniag-government-services-238216",
  "date_posted": "2026-05-17T07:01:19-04:00",
  "description": "Koniag Professional Services, LLC, a Koniag Government Service Company, is seeking a skilled Analyst to support KPS and our government cu…",
  "postal_code": "20001",
  "company_logo": "https://wjm.s3.amazonaws.com/cjng/uploads/KoniagInc.jpg",
  "valid_through": "2027-01-13T22:40:21-05:00",
  "employment_type": "OTHER",
  "security_clearance": "Public Trust"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `city` | string |  |
| `title` | string |  |
| `region` | string |  |
| `company` | string |  |
| `country` | string |  |
| `location` | string |  |
| `company_url` | string |  |
| `date_posted` | string |  |
| `description` | string |  |
| `postal_code` | string |  |
| `company_logo` | string |  |
| `valid_through` | string |  |
| `employment_type` | string |  |
| `security_clearance` | string |  |

## ClearedJobs Search API

Search cleared jobs by keyword. Only the first HTML page is available, so pagination.next is null and page 2 returns 404.

`GET | POST https://api.piloterr.com/v2/clearedjobs/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Keyword or a clearedjobs.net jobs URL. Example: analyst. A job URL returns 400. |
| `page` | number | — | Optional. Only page 1 is available. Example: 1. page=2 returns 404. pagination.next is always null. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/clearedjobs/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "analyst. A job URL returns 400.",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ClearedjobsSearch = {
  results?: {
    id?: string;
    url?: string;
    logo?: string;
    title?: string;
    posted?: string;
    company?: string;
    location?: string;
    security_clearance?: string;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "analyst. A job URL returns 400.",
});

const response = await fetch(`https://api.piloterr.com/v2/clearedjobs/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ClearedjobsSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/clearedjobs/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "analyst. A job URL returns 400."}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "1902823",
      "url": "https://clearedjobs.net/job/analyst-washington-district-of-columbia-1902823",
      "logo": "https://assets.webscribble.com/cdn-cgi/image/width=90,fit=scale-down,format=auto/https://wjm.s3.amazonaws.com/cjng/uploads/KoniagInc-100.jpg",
      "title": "Analyst",
      "posted": "October 16, 2026",
      "company": "Koniag Government Services",
      "location": "Washington, District of Columbia",
      "security_clearance": "Public Trust"
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 25,
    "total_pages": null,
    "total_results": 3170
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].logo` | string |  |
| `results[].title` | string |  |
| `results[].posted` | string |  |
| `results[].company` | string |  |
| `results[].location` | string |  |
| `results[].security_clearance` | string |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | object |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Job | Search |
|---|---|---|
| cURL (Bash) | [`job`](examples/curl/job.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`job`](examples/php/job.php) | [`search`](examples/php/search.php) |
| C# | [`job`](examples/csharp/Job.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`job`](examples/go/job.go) | [`search`](examples/go/search.go) |
| Java | [`job`](examples/java/JobExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`job`](examples/ruby/job.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`job`](examples/nodejs/job.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — ClearedJobs plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape ClearedJobs?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/clearedjobs/job` **1**, `/v2/clearedjobs/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the ClearedJobs API return?

Each endpoint returns structured JSON: **ClearedJobs Job** — `id`, `url`, `city`, `title`, `region`, `company`; **ClearedJobs Search** — `results[]`, `results[].id`, `results[].url`, `results[].logo`, `results[].title`, `results[].posted`.

### How do I paginate ClearedJobs results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>ClearedJobs is a trademark of its respective owner. This repository is not affiliated with or endorsed by ClearedJobs. Examples are released under the MIT license.</sub>
