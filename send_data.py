import requests
import time

def send_post_request(url, data, threshold):
    f_init = 0
    bot = 'AR01'
    print(bot)

    f_init += 200

    if int(threshold) < f_init:
        return

    time.sleep(1)

    # Modifying the data according to the dynamic values
    # data['bot_name'] = bot  # Update bot_name with current bot value
    # print(data)

    # Sending the POST request with dynamic URL and data
    response = requests.post(url, json=data)

    # Checking the response status
    if response.status_code == 200:
        print('POST request successful!')
    else:
        print('POST request failed with status code:', response.status_code)

    # Printing the response content (optional)
    print('Response:', response.text)

# Example dynamic URL and data
dynamic_url = 'http://localhost:3030/insert_bot_status'
# dynamic_url = 'http://localhost:3030/insert_bot_details'
for _ in range(1):  # Loop three times
    dynamic_data = {
    "Bot Name": "AR01",
    "TotalRecordsCompleted": 7000,
    "TotalRecordsProcessed": 8869,
    "DateReleasedIntoProduction": "2023-05-09",
    "AverageLengthOfRun": "1 hour 28 minutes for 88 records",
    "FrequencyOfOperation": "Daily",
    "ActionWhenBotNotRunning": "Catch up run scheduled accordingly",
    "DateFilledOut": "2024-09-02"
    }


    threshold = "8000"

    # Sending POST request using the function
    send_post_request(dynamic_url, dynamic_data, threshold)




json_data = [
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-20-03-2024.csv",
    "Total_records": 73,
    "Input_records_to_the_bot": 57,
    "Processed_records_by_bot": 52,
    "Success_result": "91.23%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-Catchup-2024-03-17.csv",
    "Total_records": 12,
    "Input_records_to_the_bot": 9,
    "Processed_records_by_bot": 8,
    "Success_result": "88.89%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-19-03-2024.csv",
    "Total_records": 28,
    "Input_records_to_the_bot": 23,
    "Processed_records_by_bot": 20,
    "Success_result": "86.96%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-17-03-2024.csv",
    "Total_records": 24,
    "Input_records_to_the_bot": 19,
    "Processed_records_by_bot": 19,
    "Success_result": "100.0%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-16-03-2024.csv",
    "Total_records": 58,
    "Input_records_to_the_bot": 45,
    "Processed_records_by_bot": 37,
    "Success_result": "82.22%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-15-03-2024.csv",
    "Total_records": 36,
    "Input_records_to_the_bot": 23,
    "Processed_records_by_bot": 20,
    "Success_result": "86.96%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-14-03-2024.csv",
    "Total_records": 41,
    "Input_records_to_the_bot": 21,
    "Processed_records_by_bot": 18,
    "Success_result": "85.71%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-13-03-2024.csv",
    "Total_records": 42,
    "Input_records_to_the_bot": 33,
    "Processed_records_by_bot": 26,
    "Success_result": "78.79%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-12-03-2024.csv",
    "Total_records": 47,
    "Input_records_to_the_bot": 30,
    "Processed_records_by_bot": 28,
    "Success_result": "93.33%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-11-03-2024.csv",
    "Total_records": 15,
    "Input_records_to_the_bot": 13,
    "Processed_records_by_bot": 11,
    "Success_result": "84.62%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-10-03-2024.csv",
    "Total_records": 12,
    "Input_records_to_the_bot": 9,
    "Processed_records_by_bot": 6,
    "Success_result": "66.67%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-09-03-2024.csv",
    "Total_records": 50,
    "Input_records_to_the_bot": 35,
    "Processed_records_by_bot": 29,
    "Success_result": "82.86%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-08-03-2024.csv",
    "Total_records": 49,
    "Input_records_to_the_bot": 29,
    "Processed_records_by_bot": 26,
    "Success_result": "89.66%"
  },
  {
    "bot_name": "AR01",
    "file_name": "AR01-MasterFile-07-03-2024.csv",
    "Total_records": 57,
    "Input_records_to_the_bot": 39,
    "Processed_records_by_bot": 34,
    "Success_result": "87.18%"
  }
]

# for abc in json_data:
#     print(abc)
#     threshold = "8000"

#     # Sending POST request using the function
#     send_post_request(dynamic_url, abc, threshold)