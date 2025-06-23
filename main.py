import os
from dotenv import load_dotenv
from julius_api import Julius

# Load environment variables
load_dotenv()

# Get Julius API token from environment
JULIUS_TOKEN = os.getenv('JULIUS_API_TOKEN')
JULIUS_MESSAGE = os.getenv('JULIUS_MESSAGE')
JULIUS_FILE_PATH = os.getenv('JULIUS_FILE_PATH')

if not JULIUS_TOKEN:
    raise ValueError("JULIUS_API_TOKEN not found in environment variables. Please check your .env file.")

# Initialize the client
julius = Julius(api_key=JULIUS_TOKEN)

def main():
    file_paths = [JULIUS_FILE_PATH]
    
    try:
        # You can still upload files individually if needed
        for file_path in file_paths:
            uploaded_filename = julius.files.upload(file_path)
            print(f"Successfully uploaded file: {uploaded_filename}")
    except Exception as e:
        print(f"Upload failed: {str(e)}")

    # Now try with chat using multiple files
    try:
        response = julius.chat.completions.create(
            model="default",
            messages=[
                # {"role": "system", "content": "You are a helpful data scientist analyzing documents."},
                {
                    "role": "user",
                    "content": f"{JULIUS_MESSAGE}",
                    "file_paths": file_paths,
                    "advanced_reasoning": True
                }
            ]
        )
        print("\nResponse:")
        print("=" * 50)
        print(response.message.content)
    except Exception as e:
        print(f"Chat failed: {str(e)}")

if __name__ == "__main__":
    main()