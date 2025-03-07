import pandas as pd
from geopy.geocoders import Nominatim
from geopy.exc import GeocoderTimedOut, GeocoderServiceError

# CSV 파일 읽기 전에 프로그램이 시작되었음을 출력
print("프로그램이 시작되었습니다.")

# CSV 파일 읽기
print("CSV 파일을 읽고 있습니다...")
df = pd.read_csv('input.csv', encoding='utf-8')

# CSV 파일을 성공적으로 읽었음을 출력
print("CSV 파일을 성공적으로 읽었습니다.")

# 'IndustryInfo' 열에서 콤마 이후 부분 제거 (도로명 주소만 사용)
df['IndustryInfo'] = df['IndustryInfo'].apply(lambda x: x.split(',')[0])

# CSV 파일을 성공적으로 읽었음을 출력
print("데이터 프레임이 성공적으로 생성되었습니다.")

# 주소를 좌표로 변환하여 새로운 열에 추가
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

# 변환 작업이 시작되었음을 출력
print("주소를 좌표로 변환하는 작업이 시작되었습니다.")

df['좌표'] = df['IndustryInfo'].apply(get_coordinates)

# 변환 작업이 완료되었음을 출력
print("주소를 좌표로 변환하는 작업이 완료되었습니다.")

# 결과를 output.csv로 저장
df.to_csv('output.csv', encoding='utf-8', index=False)

# 결과 저장이 완료되었음을 출력
print("결과는 output.csv에 저장되었습니다.")

