import numpy as np


def assign_points_to_clusters(data_points, centers):
    clusters = [[] for _ in range(len(centers))]

    for point in data_points:
        min_dis = float('inf')
        closest_center_idx = None

        for i, center in enumerate(centers):
            dis = sum((p1 - p2) ** 2 for p1, p2 in zip(point, center)) ** 0.5
            if dis < min_dis:
                min_dis = dis
                closest_center_idx = i

        clusters[closest_center_idx].append(point.tolist())

    return clusters


def k_means(data_points, k, initial_centers):
    centers = initial_centers.copy()
    clusters = assign_points_to_clusters(data_points, centers)
    return clusters


def main():
    k = int(input('Enter number of clusters : '))

    # Initial centers
    initial_centers = []
    for i in range(k):
        center = np.array([float(x) for x in input('Enter centers : ').split(',')])
        initial_centers.append(center)

    data_points = np.array([[1, 2], [2, 1], [5, 8], [7, 9], [10, 2], [12, 5]])
    clusters = k_means(data_points, k, initial_centers)

    # Print the clusters
    for i, cluster in enumerate(clusters):
        print(f"Cluster {i+1} : {cluster}")


if __name__ == '__main__':
    main()
