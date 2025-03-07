import pandas as pd
from geopy.geocoders import Nominatim
from geopy.exc import GeocoderTimedOut, GeocoderServiceError, GeocoderUnavailable

def get_coordinates(address):
    geolocator = Nominatim(user_agent="your_user_agent")

    try:
        location = geolocator.geocode(address)
        if location:
            return location.latitude, location.longitude
        else:
            print(f"좌표를 찾을 수 없습니다: {address}")
            return None, None
    except (GeocoderTimedOut, GeocoderServiceError, GeocoderUnavailable) as e:
        print(f"에러 발생: {e}")
        return None, None

# CSV 파일 읽기
try:
    df = pd.read_csv('input.csv', encoding='utf-8')
except FileNotFoundError:
    print("파일을 찾을 수 없습니다: input.csv")
    exit()

# 'Latitude'와 'Longitude' 열이 없는 경우 추가
if 'Latitude' not in df.columns:
    df['Latitude'] = None
if 'Longitude' not in df.columns:
    df['Longitude'] = None

# 'IndustryInfo' 열에서 콤마 이후 부분 제거 (도로명 주소만 사용)
df['IndustryInfo'] = df['IndustryInfo'].apply(lambda x: x.split(',')[0])

# 주소를 좌표로 변환하여 새로운 열에 추가
for i, address in enumerate(df['IndustryInfo']):
    if pd.isnull(df.at[i, 'Latitude']) or pd.isnull(df.at[i, 'Longitude']):
        lat, lon = get_coordinates(address)
        if lat is not None and lon is not None:
            df.at[i, 'Latitude'] = lat
            df.at[i, 'Longitude'] = lon
            # 변환 성공시 바로 저장
            df.to_csv('input.csv', encoding='utf-8', index=False)
        else:
            print(f"좌표 변환 실패: {address}")

