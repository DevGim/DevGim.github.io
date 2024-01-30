import pandas as pd
from geopy.geocoders import Nominatim
from geopy.exc import GeocoderTimedOut, GeocoderServiceError

# Print Program Start Message
print("프로그램이 시작되었습니다.")

# Read CSV File with No Header
print("CSV 파일을 읽고 있습니다...")
df = pd.read_csv('input.csv', header=None, names=['Name', 'Address', 'IndustryInfo', 'Neighborhood', '좌표'], encoding='utf-8')

# Print Successful CSV Read Message
print("CSV 파일을 성공적으로 읽었습니다.")

# Data Processing - Extracting Road Address
df['IndustryInfo'] = df['IndustryInfo'].apply(lambda x: x.split(',')[0])

# Print DataFrame Creation Message
print("데이터 프레임이 성공적으로 생성되었습니다.")

# Geocoding - Convert Addresses to Coordinates
geolocator = Nominatim(user_agent="geo_converter")


def get_coordinates(address):
    print(f"좌표 변환 작업 중: {address}")
    try:
        location = geolocator.geocode(address)
        if location:
            print(f"좌표 변환 성공: {address} -> {location.latitude}, {location.longitude}")
            return (location.latitude, location.longitude)
        else:
            print(f"좌표 변환 실패: {address}")
            return None
    except (GeocoderTimedOut, GeocoderServiceError):
        # 타임아웃 또는 서비스 오류 발생 시 다시 시도
        print(f"좌표 변환 중 오류 발생. 다시 시도합니다: {address}")
        return get_coordinates(address)


# Print Geocoding Start Message
print("주소를 좌표로 변환하는 작업이 시작되었습니다.")

# Apply Geocoding Function to DataFrame
df['좌표'] = df['IndustryInfo'].apply(get_coordinates)

# Print Geocoding Completion Message
print("주소를 좌표로 변환하는 작업이 완료되었습니다.")

# Save Results to Output CSV
df.to_csv('output.csv', encoding='utf-8', index=False)

# Print Save Completion Message
print("결과는 output.csv에 저장되었습니다.")
