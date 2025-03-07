import pandas as pd
from geopy.geocoders import Nominatim
from geopy.exc import GeocoderTimedOut, GeocoderServiceError
import os

# CSV 파일 읽기 전에 프로그램이 시작되었음을 출력
print("프로그램이 시작되었습니다.")

# CSV 파일 읽기
print("CSV 파일을 읽고 있습니다...")
input_file_path = 'input.csv'
output_file_path = 'output.csv'

if os.path.exists(output_file_path):
    # 이미 있는 output.csv 파일이 있다면 그 파일을 기반으로 DataFrame 생성
    df = pd.read_csv(output_file_path, encoding='utf-8')
else:
    # output.csv 파일이 없으면 input.csv를 기반으로 DataFrame 생성
    df = pd.read_csv(input_file_path, encoding='utf-8')

    # '위도'와 '경도' 열 추가
    df['위도'] = None
    df['경도'] = None

# CSV 파일을 성공적으로 읽었음을 출력
print("CSV 파일을 성공적으로 읽었습니다.")

# 'IndustryInfo' 열에서 콤마 이후 부분 제거 (도로명 주소만 사용)
df['Address'] = df['Address'].apply(lambda x: x.split(',')[0])

# CSV 파일을 성공적으로 읽었음을 출력
print("데이터 프레임이 성공적으로 생성되었습니다.")

# 주소를 좌표로 변환하여 '위도'와 '경도' 열에 추가
geolocator = Nominatim(user_agent="geo_converter")

def get_coordinates(address):
    print(f"좌표 변환 작업 중: {address}")
    try:
        location = geolocator.geocode(address)
        if location:
            print(f"좌표 변환 성공: {address} -> {location.latitude}, {location.longitude}")
            # 변환된 좌표를 DataFrame에 추가
            df.loc[df['Address'] == address, '위도'] = location.latitude
            df.loc[df['Address'] == address, '경도'] = location.longitude
            # 결과를 output.csv로 저장
            df.to_csv(output_file_path, encoding='utf-8', index=False)
        else:
            print(f"좌표 변환 실패: {address}")
    except (GeocoderTimedOut, GeocoderServiceError):
        # 타임아웃 또는 서비스 오류 발생 시 다시 시도
        print(f"좌표 변환 중 오류 발생. 다시 시도합니다: {address}")
        return get_coordinates(address)

# 변환 작업이 시작되었음을 출력
print("주소를 좌표로 변환하는 작업이 시작되었습니다.")

# '위도'와 '경도'가 모두 NaN이면서 이전에 실패한 경우에만 좌표 변환 시도
for address in df[df['위도'].isna() & df['경도'].isna()]['Address'].unique():
    if pd.isna(df.loc[df['Address'] == address, '위도'].iloc[0]):
        get_coordinates(address)

# 변환 작업이 완료되었음을 출력
print("주소를 좌표로 변환하는 작업이 완료되었습니다.")

# 결과를 output.csv로 저장 (마지막으로 성공한 결과까지 반영)
df.to_csv(output_file_path, encoding='utf-8', index=False)

# 결과 저장이 완료되었음을 출력
print(f"결과는 {output_file_path}에 저장되었습니다.")

