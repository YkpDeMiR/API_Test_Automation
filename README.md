## Design Patterns
- **Keyword Driven Testing** — test logic abstracted into reusable keywords
- **Page Object Pattern** — API layer separated in keywords folder
- **DRY Principle** — test data managed centrally in variables files
- **Custom Library** — Python-based reusable validation methods

## Setup & Installation

### Prerequisites
- Python 3.14+
- pip

### Installation
```bash
git clone https://github.com/YkpDeMiR/API_Test_Automation.git
cd API_Test_Automation
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements/requirements.txt
```

## Running Tests

### Run All Tests
```bash
./run_tests.sh
```

### Run Specific Module
```bash
robot --outputdir results tests/auth/
robot --outputdir results tests/booking/
robot --outputdir results tests/e2e/
```

## Test Coverage

### API Under Test
Restful-Booker: https://restful-booker.herokuapp.com

### Test Modules
| Module | Positive | Negative | Total |
|--------|----------|----------|-------|
| Auth | 1 | 2 | 3 |
| GET | 2 | 1 | 3 |
| POST | 2 | 1 | 3 |
| PUT | 2 | 2 | 4 |
| DELETE | 2 | 1 | 3 |
| E2E | 1 | 1 | 2 |
| **Total** | **10** | **8** | **18** |

## CI/CD
Automated test execution on every push via GitHub Actions.
Results are uploaded as artifacts after each run.

## Test Results
Reports are generated in the `results/` folder after each run:
- `results/report.html` — Summary report
- `results/log.html` — Detailed execution log
- `results/output.xml` — CI/CD integration output