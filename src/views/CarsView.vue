<template>
  <div >
    <!-- <h1 class="mb-4">Cars List</h1> -->
    <table class="table table-striped table-hover">
      <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Brand</th>
          <th>Model</th>
          <th>Color</th>
          <th>Year</th>
          <th>Price</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="car in cars" :key="car.id">
          <td>{{ car.id }}</td>
          <td>{{ car.brand }}</td>
          <td>{{ car.model }}</td>
          <td>{{ car.color }}</td>
          <td>{{ car.year }}</td>
          <td>{{ car.price }} PHP </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'CarsView',
  data() {
    return {
      cars: []
    };
  },
  methods: {
    async fetchCarList() {
      console.log('fetchCarList called');
      
      try {
        const response = await axios.get('http://10.109.4.244:8000/api/cars', {
          headers: {
            'Content-Type': 'application/json'
          }
        });
        console.log('Response received:', response);
        console.log('Response data:', response.data);
        this.cars = response.data;
        console.log('Cars set to:', this.cars);
      } 
      
      catch (error) {
        console.error("Error fetching car list: Unexpected Error");
      }
    }
  },
  mounted() {
    this.fetchCarList();
  }
}
</script>
