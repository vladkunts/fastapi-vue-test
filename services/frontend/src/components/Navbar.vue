<template>
  <div class="navbar">
    <div class="title">
      <img alt="Vue logo" class="logo" src="../assets/logo.svg" width="20" height="20" />
      <span>Dashboard</span>
    </div>
    <a href="" @click.prevent="logout">Log Out</a>
  </div>
</template>

<script>
export default {
  name: 'Navbar',
  methods: {
    logout() {
      localStorage.removeItem('token');
      this.$router.push('/');
    }
  }
}
</script>

<style scoped>
  .navbar {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    padding: 10px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #333;
    color: white;
    text-align: center;
  }
  .title {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .title span {
    font-size: 16px;
    font-weight: bold;
    text-transform: uppercase;
  }
  a {
    color: white;
  }
</style>
