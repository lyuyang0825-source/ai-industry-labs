.PHONY: demo test clean

demo:
	bash scripts/run_all_demos.sh

test:
	cd products/clinote && python3 -m unittest discover -s tests
	cd products/shorts_factory && python3 -m unittest discover -s tests
	cd products/support_copilot && python3 -m unittest discover -s tests
	cd products/driveloop && python3 -m unittest discover -s tests

clean:
	rm -rf products/*/demo_out products/driveloop/data/logs
	find . -name __pycache__ -type d -prune -exec rm -rf {} +
