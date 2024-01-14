#!/bin/sh

echo "testing.."
if
python -m unittest discover -s search_engine_crawler/tests/ 2> >(grep -i OK)
then 
    echo "tests went fine!"
else
    echo "tests went wrong.."
    exit 1
fi
echo "report:"
if coverage run -m unittest discover -s search_engine_crawler/tests/ 2> >(grep -i OK)
then 
    echo "app covered with tests!"
else
    echo "Report went wrong.."
    exit 1
fi
coverage report --include search_engine_crawler/crawler/crawler.py
